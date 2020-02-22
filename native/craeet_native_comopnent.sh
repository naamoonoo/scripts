#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument with s:screens/c:components ComponentName "
 exit 0

fi


if [ "$1" == "c" ]; then
	FOLDER="components"
elif [ "$1" == "s" ]; then
	FOLDER="screens"
else
	echo "put argument with s:screens/c:Components ComponentName "
	exit1
fi

FILE_NAME=$2
FIRST_CAP="$(tr '[:lower:]' '[:upper:]' <<< ${FOLDER:0:1})${FOLDER:1}"
APPEND=`echo "${FIRST_CAP%?}"`
STYLE_COMPONENT="import { StyleSheet } from 'react-native';\n\n

const styles = StyleSheet.create({
	container: {

	}
});\n\n

export default styles;
"

echo `mkdir src/${FOLDER}/${FILE_NAME}`

echo `echo "export { default as ${FILE_NAME} } from './${FILE_NAME}${APPEND}';" > src/${FOLDER}/${FILE_NAME}/index.ts`

echo `echo "
import React from 'react';
import { View, Text } from 'react-native';
import styles from './styles';

interface IProps {
}

const ${FILE_NAME}${APPEND}: React.FC<IProps> = () => {
	return <View style={styles.container}><Text>${FILE_NAME}${APPEND}</Text></View>;
};

export default ${FILE_NAME}${APPEND};" > src/${FOLDER}/${FILE_NAME}/${FILE_NAME}${APPEND}.tsx`

echo `echo ${STYLE_COMPONENT} > src/${FOLDER}/${FILE_NAME}/styles.ts`

echo `echo "import { gql } from 'apollo-boost'

	" > src/${FOLDER}/${FILE_NAME}/${FILE_NAME}Queries.ts`
