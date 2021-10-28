import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const int byteSize = 1;
const int int16Size = 2;
const int int32Size = 4;
const int float32Size = 4;
const int float64Size = 4;

class Telemetry extends ChangeNotifier {

  var isRaceOn = 0;                                //s32
  var timeStampMs = 0;                             //u32
  var engineMaxRpm = 0.0;                          //f32
  var engineIdleRpm = 0.0;                         //f32
  var currentEngineRpm = 0.0;                      //f32
  var accelerationX = 0.0;                         //f32
  var accelerationY = 0.0;                         //f32
  var accelerationZ = 0.0;                         //f32
  var velocityX = 0.0;                             //f32
  var velocityY = 0.0;                             //f32
  var velocityZ = 0.0;                             //f32
  var angularVelocityX = 0.0;                      //f32
  var angularVelocityY = 0.0;                      //f32
  var angularVelocityZ = 0.0;                      //f32
  var yaw = 0.0;                                   //f32
  var pitch = 0.0;                                 //f32
  var roll = 0.0;                                  //f32
  var normalizedSuspensionTravelFrontLeft = 0.0;   //f32
  var normalizedSuspensionTravelFrontRight = 0.0;  //f32
  var normalizedSuspensionTravelRearLeft = 0.0;    //f32
  var normalizedSuspensionTravelRearRight = 0.0;   //f32
  var tireSlipRatioFrontLeft = 0.0;                //f32
  var tireSlipRatioFrontRight = 0.0;               //f32
  var tireSlipRatioRearLeft = 0.0;                 //f32
  var tireSlipRatioRearRight = 0.0;                //f32
  var wheelRotationSpeedFrontLeft = 0.0;           //f32
  var wheelRotationSpeedFrontRight = 0.0;          //f32
  var wheelRotationSpeedRearLeft = 0.0;            //f32
  var wheelRotationSpeedRearRight = 0.0;           //f32
  var wheelOnRumbleStripFrontLeft = 0.0;           //f32
  var wheelOnRumbleStripFrontRight = 0.0;          //f32
  var wheelOnRumbleStripRearLeft = 0.0;            //f32
  var wheelOnRumbleStripRearRight = 0.0;           //f32
  var wheelInPuddleDepthFrontLeft = 0.0;           //f32
  var wheelInPuddleDepthFrontRight = 0.0;          //f32
  var wheelInPuddleDepthRearLeft = 0.0;            //f32
  var wheelInPuddleDepthRearRight = 0.0;           //f32
  var surfaceRumbleFrontLeft = 0.0;                //f32
  var surfaceRumbleFrontRight = 0.0;               //f32
  var surfaceRumbleRearLeft = 0.0;                 //f32
  var surfaceRumbleRearRight = 0.0;                //f32
  var tireSlipAngleFrontLeft = 0.0;                //f32
  var tireSlipAngleFrontRight = 0.0;               //f32
  var tireSlipAngleRearLeft = 0.0;                 //f32
  var tireSlipAngleRearRight = 0.0;                //f32
  var tireCombinedSlipFrontLeft = 0.0;             //f32
  var tireCombinedSlipFrontRight = 0.0;            //f32
  var tireCombinedSlipRearLeft = 0.0;              //f32
  var tireCombinedSlipRearRight = 0.0;             //f32
  var suspensionTravelMetersFrontLeft = 0.0;       //f32
  var suspensionTravelMetersFrontRight = 0.0;      //f32
  var suspensionTravelMetersRearLeft = 0.0;        //f32
  var suspensionTravelMetersRearRight = 0.0;       //f32
  var carOrdinal = 0; //Unique ID of the car make/model, s32
  var carClass = 0; //Between 0 (D -- worst cars) and 7 (X class -- best cars) inclusive, s32
  var carPerformanceIndex = 0; //Between 100 (slowest car) and 999 (fastest car) inclusive, s32
  var drivetrainType = 0; //Corresponds to EDrivetrainType; 0 = FWD, 1 = RWD, 2 = AWD, s32
  var numCylinders = 0; //Number of cylinders in the engine, s32
  var unknownData = 0.0; //To pass unknown 8 byte data
  var positionX = 0.0;                             //f32
  var positionY = 0.0;                             //f32
  var positionZ = 0.0;                             //f32
  var speed = 0.0;                                 //f32
  var power = 0.0; //kw                            //f32
  var torque = 0.0; //N*m                          //f32
  var tireTempFrontLeft = 0.0;                     //f32
  var tireTempFrontRight = 0.0;                    //f32
  var tireTempRearLeft = 0.0;                      //f32
  var tireTempRearRight = 0.0;                     //f32
  var boost = 0.0;                                 //f32
  var fuel = 0.0;                                  //f32
  var distanceTraveled = 0.0;                      //f32
  var bestLap = 0.0;                               //f32
  var lastLap = 0.0;                               //f32
  var currentLap = 0.0;                            //f32
  var currentRaceTime = 0.0;                       //f32
  var lapNumber = 0;                               //u16
  var racePosition = 0;                            //u8
  var accel = 0;                                   //u8
  var brake = 0;                                   //u8
  var clutch = 0;                                  //u8
  var handBrake = 0;                               //u8
  var gear = 0;                                    //u8
  var steer = 0;                                   //s8
  var normalizedDrivingLine = 0;                   //s8
  var normalizedAIBrakeDifference = 0;             //s8

  resolveData(ByteData byteData) {

    int dataIndex = 0;
    Endian endianType = Endian.little;

    isRaceOn = byteData.getInt32(dataIndex, endianType);
    dataIndex += int32Size;

    timeStampMs = byteData.getUint32(dataIndex, endianType);
    dataIndex += int32Size;

    engineMaxRpm = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    engineIdleRpm = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    currentEngineRpm = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    accelerationX = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    accelerationY = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    accelerationZ = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    velocityX = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    velocityY = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    velocityZ = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    angularVelocityX = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    angularVelocityY = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    angularVelocityZ = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    yaw = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    pitch = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    roll = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    normalizedSuspensionTravelFrontLeft = byteData.getFloat32(dataIndex, 
        endianType);
    dataIndex += float32Size;

    normalizedSuspensionTravelFrontRight = byteData.getFloat32(dataIndex,
        endianType);
    dataIndex += float32Size;

    normalizedSuspensionTravelRearLeft = byteData.getFloat32(dataIndex,
        endianType);
    dataIndex += float32Size;

    normalizedSuspensionTravelRearRight = byteData.getFloat32(dataIndex,
        endianType);
    dataIndex += float32Size;

    tireSlipRatioFrontLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireSlipRatioFrontRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireSlipRatioRearLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireSlipRatioRearRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelRotationSpeedFrontLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelRotationSpeedFrontRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelRotationSpeedRearLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelRotationSpeedRearRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelOnRumbleStripFrontLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelOnRumbleStripFrontRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;
    
    wheelOnRumbleStripRearLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelOnRumbleStripRearRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelInPuddleDepthFrontLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelInPuddleDepthFrontRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelInPuddleDepthRearLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    wheelInPuddleDepthRearRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    surfaceRumbleFrontLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    surfaceRumbleFrontRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    surfaceRumbleRearLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    surfaceRumbleRearRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;
    
    tireSlipAngleFrontLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireSlipAngleFrontRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireSlipAngleRearLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireSlipAngleRearRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireCombinedSlipFrontLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireCombinedSlipFrontRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireCombinedSlipRearLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireCombinedSlipRearRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    suspensionTravelMetersFrontLeft = byteData.getFloat32(dataIndex,
        endianType);
    dataIndex += float32Size;

    suspensionTravelMetersFrontRight = byteData.getFloat32(dataIndex,
        endianType);
    dataIndex += float32Size;

    suspensionTravelMetersRearLeft = byteData.getFloat32(dataIndex,
        endianType);
    dataIndex += float32Size;

    suspensionTravelMetersRearRight = byteData.getFloat32(dataIndex,
        endianType);
    dataIndex += float32Size;
    
    carOrdinal = byteData.getInt32(dataIndex, endianType);
    dataIndex += int32Size;

    carClass = byteData.getInt32(dataIndex, endianType);
    dataIndex += int32Size;

    carPerformanceIndex = byteData.getInt32(dataIndex, endianType);
    dataIndex += int32Size;

    drivetrainType = byteData.getInt32(dataIndex, endianType);
    dataIndex += int32Size;

    numCylinders = byteData.getInt32(dataIndex, endianType);
    dataIndex += int32Size;

    unknownData = byteData.getFloat64(dataIndex, endianType);
    dataIndex += float64Size;

    positionX = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    positionY = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    positionZ = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    speed = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    power = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    torque = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireTempFrontLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireTempFrontRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireTempRearLeft = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    tireTempRearRight = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    boost = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    fuel = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    distanceTraveled = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    bestLap = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    lastLap = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    currentLap = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    currentRaceTime = byteData.getFloat32(dataIndex, endianType);
    dataIndex += float32Size;

    lapNumber = byteData.getUint16(dataIndex, endianType);
    dataIndex += int16Size;

    racePosition = byteData.getUint8(dataIndex);
    dataIndex += byteSize;

    accel = byteData.getUint8(dataIndex);
    dataIndex += byteSize;

    brake = byteData.getUint8(dataIndex);
    dataIndex += byteSize;

    clutch = byteData.getUint8(dataIndex);
    dataIndex += byteSize;

    handBrake = byteData.getUint8(dataIndex);
    dataIndex += byteSize;

    gear = byteData.getUint8(dataIndex);
    dataIndex += byteSize;

    steer = byteData.getUint8(dataIndex);
    dataIndex += byteSize;

    normalizedDrivingLine = byteData.getInt8(dataIndex);
    dataIndex += byteSize;

    normalizedAIBrakeDifference = byteData.getInt8(dataIndex);
    dataIndex += byteSize;

    notifyListeners();

  }
}