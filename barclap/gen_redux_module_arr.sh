#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument with s:screens/c:components ComponentName "
 exit 0

fi

FILE_NAME=$1
FIRST_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${FILE_NAME:0:1})${FILE_NAME:1}"
CAP="$(tr '[:lower:]' '[:upper:]' <<< ${FILE_NAME:0})"
APPEND=`echo "${FIRST_CAP%?}"`

secho `mkdir src/modules/${FILE_NAME}`

echo `echo "
export { default } from './reducer';
export * from './actions';
export * from './types';
" > src/modules/${FILE_NAME}/index.ts`

echo `echo "
import { ActionType } from 'typesafe-actions';
import * as actions from './actions';

export type TokenAction = ActionType<typeof actions>;

export type TokenState = I${FIRST_CAP}[];

export interface I${FIRST_CAP} {
}

" > src/modules/${FILE_NAME}/types.ts`

echo `echo "
import { createAction } from 'typesafe-actions';

export const CREATE_${CAP} = '${FILE_NAME}/CREATE_${CAP}';
export const UDPATE_${CAP} = '${FILE_NAME}/UDPATE_${CAP}';
export const DELETE_${CAP} = '${FILE_NAME}/DELETE_${CAP}';

export const create${FIRST_CAP} = createAction(CREATE_${CAP})();
export const update${FIRST_CAP} = createAction(UDPATE_${CAP})();
export const delete${FIRST_CAP} = createAction(DELETE_${CAP})();

" > src/modules/${FILE_NAME}/actions.ts`

echo `echo "
import { createReducer } from 'typesafe-actions';
import { I${FIRST_CAP}, TokenState, TokenAction } from './types';
import {
	CREATE_${CAP},
	UDPATE_${CAP},
	DELETE_${CAP}
} from './actions';

const initialState: I${FIRST_CAP}[] = [];

const ${FILE_NAME} = createReducer<TokenState, TokenAction>(initialState, {
	[CREATE_${CAP}]: (state, { payload: { token } }) => {
		return { ...state,  };
	},
	[UDPATE_${CAP}]: (state, { payload: { id, amount } }) =>
		state.map(product =>
			product.product_id === id
				? {
						...product,
						quantity: product.quantity + amount,
				  }
				: product,
		),
	[DELETE_${CAP}]: (state, { payload: { id } }) =>
		state.filter(product => product.product_id !== id),
});

export default ${FILE_NAME};

" > src/modules/${FILE_NAME}/reducer.ts`


# hooks
echo `echo "
import { useSelector, useDispatch } from 'react-redux';
import { RootState } from '../modules';
import {
	create${FIRST_CAP},
	update${FIRST_CAP},
	delete${FIRST_CAP},
	I${FIRST_CAP},
} from '../modules/${FILE_NAME}';

export const use${FIRST_CAP} = () => {
	const dispatch = useDispatch();

	const ${FILE_NAME} = useSelector((state: RootState) => state.${FILE_NAME});

	const onCreate${FIRST_CAP} = (${FILE_NAME}: I${FIRST_CAP}) => dispatch(create${FIRST_CAP}(${FILE_NAME}));

	const onUpdate${FIRST_CAP} = (id: number, amount: number) => dispatch(update${FIRST_CAP}({ id, amount }));

	const onDelete${FIRST_CAP} = (id: number) => dispatch(delete${FIRST_CAP}({ id }));

	return {
		${FILE_NAME},
		onCreate${FIRST_CAP},
		onUpdate${FIRST_CAP},
		onDelete${FIRST_CAP},
	};
};

" > src/hooks/use${FIRST_CAP}.ts`
