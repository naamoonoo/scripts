#!/usr/bin/env bash

FILE_NAME=$1
FIRST_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${FILE_NAME:0:1})${FILE_NAME:1}"
CAP="$(tr '[:lower:]' '[:upper:]' <<< ${FILE_NAME:0})"

echo `mkdir src/modules/${FILE_NAME}`

echo `echo "
export { default } from './reducer';
export * from './actions';
export * from './types';
export * from './thunks';

" > src/modules/${FILE_NAME}/index.ts`

echo `echo "
import { ActionType } from 'typesafe-actions';
import * as actions from './actions';
import { AsyncState } from '../../utils/reducerUtils';
import { I${FIRST_CAP} } from '../../API/${FILE_NAME}';

export type ${FIRST_CAP}Action = ActionType<typeof actions>;

export type ${FIRST_CAP}State = AsyncState<I${FIRST_CAP}, Error>;

" > src/modules/${FILE_NAME}/types.ts`

echo `echo "
import { createAsyncAction } from 'typesafe-actions';
import { AxiosError } from 'axios';
import { I${FIRST_CAP} } from '../../API/${FILE_NAME}';

export const GET_${CAP} = '${FILE_NAME}/GET_${CAP}';
export const GET_${CAP}_SUCCESS = '${FILE_NAME}/GET_${CAP}_SUCCESS';
export const GET_${CAP}_ERROR = '${FILE_NAME}/GET_${CAP}_ERROR';

export const get${FIRST_CAP}Async = createAsyncAction(
	GET_${CAP},
	GET_${CAP}_SUCCESS,
	GET_${CAP}_ERROR,
)<undefined, I${FIRST_CAP}, AxiosError>();

" > src/modules/${FILE_NAME}/actions.ts`

echo `echo "
import { createReducer } from 'typesafe-actions';
import { ${FIRST_CAP}Action, ${FIRST_CAP}State } from './types';
import { get${FIRST_CAP}Async } from './actions';
import {
	asyncState,
	createAsyncReducer,
	transformToArray,
} from '../../utils/reducerUtils';

const initialState: ${FIRST_CAP}State = {
	...asyncState.initial(),
};

const ${FILE_NAME} = createReducer<${FIRST_CAP}State, ${FIRST_CAP}Action>(
	initialState,
).handleAction(
	transformToArray(get${FIRST_CAP}Async),
	createAsyncReducer(get${FIRST_CAP}Async),
);

export default ${FILE_NAME};
" > src/modules/${FILE_NAME}/reducer.ts`

echo `echo "
import { get${FIRST_CAP}} from '../../API/${FILE_NAME}';
import { get${FIRST_CAP}Async } from './actions';
import { createAsyncThunk } from '../../utils/createAsyncThunk';
import { I${FIRST_CAP}} from '../../API/${FILE_NAME}';

const onSucessHandler = (data: I${FIRST_CAP}) => {
};

export const get${FIRST_CAP}Thunk = createAsyncThunk(
	get${FIRST_CAP}Async,
	get${FIRST_CAP}
	onSucessHandler,
);

" > src/modules/${FILE_NAME}/thunk.ts`


# hooks
echo `echo "
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../modules';
import {  } from '../modules/${FILE_NAME}';

export const use${FIRST_CAP} = () => {
	const dispatch = useDispatch();

	return {
		...useSelector((state: RootState) => state.${FILE_NAME}),
	};
};


" > src/hooks/use${FIRST_CAP}.ts`
