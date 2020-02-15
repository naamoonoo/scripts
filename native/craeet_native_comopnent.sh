#!/usr/bin/env bash

if [ -z "$*" ]; then
 echo "put argument with s:screens/c:components ComponentName "
 exit 0

fi


if [ "$1" == "c" ]; then
	FOLDER="components"
elif [ "$1" == "r" ]; then
	FOLDER="screens"
else
	echo "put argument with s:screens/c:Components ComponentName "
	exit1
fi

FILE_NAME=$2
STYLE_COMPONENT="import { StyleSheet } from 'react-native';

const styles = StyleSheet.create({
	container: {
		flex: 1,
		backgroundColor: '#fff',
		alignItems: 'center',
		justifyContent: 'center'
	}
});

export default styles;
"

echo `mkdir src/${FOLDER}/${FILE_NAME}`

echo `echo "export { default as ${FILE_NAME} } from "./${FILE_NAME}";" > src/${FOLDER}/${FILE_NAME}/index.ts`

echo `echo "
import React from 'react';
import { View } from 'react-native';
import styles from "./styles";

interface IProps {
}

const ${FILE_NAME}: React.FC<IProps> = () => {
	return <View>${FILE_NAME}</View>;
};

export default ${FILE_NAME};" > src/${FOLDER}/${FILE_NAME}/${FILE_NAME}.tsx`

echo `echo ${STYLE_COMPONENT} > src/${FOLDER}/${FILE_NAME}/styles.ts`
