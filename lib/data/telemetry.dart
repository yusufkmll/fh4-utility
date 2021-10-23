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

  static var isRaceOn = 0;                                //s32
  static var timeStampMs = 0;                             //u32
  static var engineMaxRpm = 0.0;                          //f32
  static var engineIdleRpm = 0.0;                         //f32
  static var currentEngineRpm = 0.0;                      //f32
  static var accelerationX = 0.0;                         //f32
  static var accelerationY = 0.0;                         //f32
  static var accelerationZ = 0.0;                         //f32
  static var velocityX = 0.0;                             //f32
  static var velocityY = 0.0;                             //f32
  static var velocityZ = 0.0;                             //f32
  static var angularVelocityX = 0.0;                      //f32
  static var angularVelocityY = 0.0;                      //f32
  static var angularVelocityZ = 0.0;                      //f32
  static var yaw = 0.0;                                   //f32
  static var pitch = 0.0;                                 //f32
  static var roll = 0.0;                                  //f32
  static var normalizedSuspensionTravelFrontLeft = 0.0;   //f32
  static var normalizedSuspensionTravelFrontRight = 0.0;  //f32
  static var normalizedSuspensionTravelRearLeft = 0.0;    //f32
  static var normalizedSuspensionTravelRearRight = 0.0;   //f32
  static var tireSlipRatioFrontLeft = 0.0;                //f32
  static var tireSlipRatioFrontRight = 0.0;               //f32
  static var tireSlipRatioRearLeft = 0.0;                 //f32
  static var tireSlipRatioRearRight = 0.0;                //f32
  static var wheelRotationSpeedFrontLeft = 0.0;           //f32
  static var wheelRotationSpeedFrontRight = 0.0;          //f32
  static var wheelRotationSpeedRearLeft = 0.0;            //f32
  static var wheelRotationSpeedRearRight = 0.0;           //f32
  static var wheelOnRumbleStripFrontLeft = 0.0;           //f32
  static var wheelOnRumbleStripFrontRight = 0.0;          //f32
  static var wheelOnRumbleStripRearLeft = 0.0;            //f32
  static var wheelOnRumbleStripRearRight = 0.0;           //f32
  static var wheelInPuddleDepthFrontLeft = 0.0;           //f32
  static var wheelInPuddleDepthFrontRight = 0.0;          //f32
  static var wheelInPuddleDepthRearLeft = 0.0;            //f32
  static var wheelInPuddleDepthRearRight = 0.0;           //f32
  static var surfaceRumbleFrontLeft = 0.0;                //f32
  static var surfaceRumbleFrontRight = 0.0;               //f32
  static var surfaceRumbleRearLeft = 0.0;                 //f32
  static var surfaceRumbleRearRight = 0.0;                //f32
  static var tireSlipAngleFrontLeft = 0.0;                //f32
  static var tireSlipAngleFrontRight = 0.0;               //f32
  static var tireSlipAngleRearLeft = 0.0;                 //f32
  static var tireSlipAngleRearRight = 0.0;                //f32
  static var tireCombinedSlipFrontLeft = 0.0;             //f32
  static var tireCombinedSlipFrontRight = 0.0;            //f32
  static var tireCombinedSlipRearLeft = 0.0;              //f32
  static var tireCombinedSlipRearRight = 0.0;             //f32
  static var suspensionTravelMetersFrontLeft = 0.0;       //f32
  static var suspensionTravelMetersFrontRight = 0.0;      //f32
  static var suspensionTravelMetersRearLeft = 0.0;        //f32
  static var suspensionTravelMetersRearRight = 0.0;       //f32
  static var carOrdinal = 0; //Unique ID of the car make/model, s32
  static var carClass = 0; //Between 0 (D -- worst cars) and 7 (X class -- best cars) inclusive, s32
  static var carPerformanceIndex = 0; //Between 100 (slowest car) and 999 (fastest car) inclusive, s32
  static var drivetrainType = 0; //Corresponds to EDrivetrainType; 0 = FWD, 1 = RWD, 2 = AWD, s32
  static var numCylinders = 0; //Number of cylinders in the engine, s32
  static var unknownData = 0.0; //To pass unknown 8 byte data
  static var positionX = 0.0;                             //f32
  static var positionY = 0.0;                             //f32
  static var positionZ = 0.0;                             //f32
  static var speed = 0.0;                                 //f32
  static var power = 0.0; //kw                            //f32
  static var torque = 0.0; //N*m                          //f32
  static var tireTempFrontLeft = 0.0;                     //f32
  static var tireTempFrontRight = 0.0;                    //f32
  static var tireTempRearLeft = 0.0;                      //f32
  static var tireTempRearRight = 0.0;                     //f32
  static var boost = 0.0;                                 //f32
  static var fuel = 0.0;                                  //f32
  static var distanceTraveled = 0.0;                      //f32
  static var bestLap = 0.0;                               //f32
  static var lastLap = 0.0;                               //f32
  static var currentLap = 0.0;                            //f32
  static var currentRaceTime = 0.0;                       //f32
  static var lapNumber = 0;                               //u16
  static var racePosition = 0;                            //u8
  static var accel = 0;                                   //u8
  static var brake = 0;                                   //u8
  static var clutch = 0;                                  //u8
  static var handBrake = 0;                               //u8
  static var gear = 0;                                    //u8
  static var steer = 0;                                   //s8
  static var normalizedDrivingLine = 0;                   //s8
  static var normalizedAIBrakeDifference = 0;             //s8

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


  }
}