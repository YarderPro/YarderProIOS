import { Image, StyleSheet, TextInput, Text } from 'react-native';

import ParallaxScrollView from '@/components/ParallaxScrollView';
import { ThemedText } from '@/components/ThemedText';  
import { ThemedView } from '@/components/ThemedView';
import React from 'react';
  
export default function deflectionCalcScreen() {
    const [sGround, onsGroundChange] = React.useState('');
    const [sMid, onsMidChange] = React.useState('');
    const [towerH, ontowerHChange] = React.useState('');
    const [length, onlengthChange] = React.useState('');

  return (
    <ParallaxScrollView
      headerBackgroundColor={{ light: '#A1CEDC', dark: '#1D3D47' }}
      headerImage={
        <Image
          source={require('@/assets/images/partial-react-logo.png')}
          style={styles.reactLogo}
        />
      }>
      <ThemedView style={styles.titleContainer}>
        <ThemedText type="title">Deflection Calculator</ThemedText>
      </ThemedView>
      <ThemedView style={styles.stepContainer}>
        <ThemedText type="subtitle">Enter values below: </ThemedText>
        <ThemedText type="default" style={styles.formula}>
          % Deflection = (Sground – Smidspan) / 2.2 + (TowerH / Length) / 2.2
        </ThemedText>
        <TextInput 
            style={styles.textInput} 
            onChangeText={onsGroundChange} 
            value={(sGround )} 
            placeholder="% slope to ground..." 
            keyboardType="numeric"
        />
        <TextInput 
            style={styles.textInput} 
            onChangeText={onsMidChange} 
            value={(sMid )} 
            placeholder="% midspan slope to carriage..." 
            keyboardType="numeric"
        />
        <TextInput 
            style={styles.textInput} 
            onChangeText={ontowerHChange} 
            value={(towerH )} 
            placeholder="Tower height..." 
            keyboardType="numeric"
        />
        <TextInput 
            style={styles.textInput} 
            onChangeText={onlengthChange} 
            value={(length )} 
            placeholder="Cable length..." 
            keyboardType="numeric"
        />
        <ThemedText type="subtitle">{calculateDeflection(+sGround, +sMid, +towerH, +length)}</ThemedText>

      </ThemedView>
    </ParallaxScrollView>
  );
}

// function to calculate %deflection
function calculateDeflection(sGround: number, sMid: number, towerH: number, length: number) {
    if (sGround <= 0 || sMid <= 0 || towerH <= 0 || length <= 0) {
      return;
    }

    var result = ( (sGround - sMid) / 2.2) + ( (towerH / length) / 2.2 );

    return "%Deflection = " + result;
}

const styles = StyleSheet.create({
  titleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  stepContainer: {
    gap: 8,
    marginBottom: 8,
  },
  reactLogo: {
    height: 178,
    width: 290,
    bottom: 0,
    left: 0,
    position: 'absolute',
  },
  textInput: {
    borderColor: 'black',
    borderStyle: 'solid',
    borderWidth: 1,
    height: 30,
    width: 220,
    padding: 3,
  },
  formula: {
    fontSize: 10,
    fontStyle: 'italic',
  },
});
