//
//  Closures.swift
//  UtilityKit
//
//  Created by Dikran Teymur on 1.01.2024.
//

public typealias VoidClosure = () -> Void
public typealias BoolClosure = (Bool) -> Void
public typealias IntClosure = (Int) -> Void
public typealias StringClosure = (String) -> Void
public typealias ArrayClosure<T: Any> = ([T]) -> Void
public typealias AnyClosure<T: Any> = (T) -> Void
