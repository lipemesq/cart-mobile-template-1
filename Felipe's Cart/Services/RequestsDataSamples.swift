//
//  RequestsDataSamples.swift
//  Felipe's Cart
//
//  Created by Felipe Mesquita on 24/11/20.
//

import Foundation

class RSDataSamples {
   static let listData =
"""
   [
      {
                "availableFor": [
                    "dinein",
                    "takeout",
                    "delivery",
                    "catering"
                ],
                "id": "5e5f935c3cee33874a8e31a2",
                "menuId": "5e4ff40b4866fc56b1ff9ba0",
                "name": "Vegetarian Breakfast",
                "restaurantName": "Indigo on the Roof",
                "sectionIds": [
                    "5e4ff91a4866fc56b1ff9bd1"
                ],
                "location": {
                    "latitude": 37.427995,
                    "longitude": -122.129606
                },
                "photo": "https://storage.googleapis.com/rockspoon-stg-bucket/no_5e8f29de0dd5865b75765aa2.jpeg",
                "prices": [
                    {
                        "amount": 1450,
                        "value": 1450,
                        "currency": {
                            "decimal": 2,
                            "symbol": "$",
                            "type": "USD"
                        }
                    }
                ],
                "rating": 5,
                "tags": [
                    {
                        "name": "food>"
                    },
                    {
                        "name": "food>ABCD"
                    },
                    {
                        "name": "food>Vegetarian"
                    },
                    {
                        "name": "item>Vegetarian Breakfast"
                    },
                ],
                "venueId": "5d1f43d60314640d77cfdb46"
            }
   ]
"""
   
   static let detailData =
"""
{
    "alcoholicAttributes": {
        "age": 0,
        "alcoholByVolume": 0,
        "grape": null,
        "vintage": 0
    },
    "applyTaxDeliveryTakeout": false,
    "availability": [],
    "availableFor": [
        "curbside",
        "delivery",
        "dinein",
        "takeout"
    ],
    "beverageAttributes": {},
    "category": "food",
    "course": 6,
    "createdAt": "2020-04-02T21:12:14.238Z",
    "description": "test",
    "id": "5e86552e0b2595e44af27817",
    "isAvailable": false,
    "photos": [
        {
            "contentType": "jpeg",
            "id": "5ea1ec0e0dd5865b75765afc",
            "resolutions": {
                "default": {
                    "height": 300,
                    "url": "https://storage.googleapis.com/rockspoon-stg-bucket/no_5ea1ec0e0dd5865b75765afc.jpeg",
                    "width": 300
                },
                "high": {
                    "height": 1000,
                    "url": "https://storage.googleapis.com/rockspoon-stg-bucket/hi_5ea1ec0e0dd5865b75765afc.jpeg",
                    "width": 1000
                },
                "low": {
                    "height": 80,
                    "url": "https://storage.googleapis.com/rockspoon-stg-bucket/lo_5ea1ec0e0dd5865b75765afc.jpeg",
                    "width": 80
                }
            }
        }
    ],
    "routing": [
        "HOT"
    ],
    "sizesAndPrices": [
        {
            "bundleItemSizeAttributes": null,
            "bundleSectionSizeAttributes": null,
            "id": "5ea1ec19c8393636ebc2fec4",
            "menuAttributes": [
                {
                    "index": 0,
                    "isVariablePrice": false,
                    "menuId": "5e6bee157ed0c3cbff31bec4",
                    "menuSectionId": "5e7b98f40b2595e44af26c1b",
                    "menuType": "standard",
                    "price": 500
                }
            ],
            "name": "Small"
        },
        {
            "bundleItemSizeAttributes": null,
            "bundleSectionSizeAttributes": null,
            "id": "5ea1ec19c8393636ebc2fec5",
            "menuAttributes": [
                {
                    "index": 0,
                    "isVariablePrice": false,
                    "menuId": "5e6bee157ed0c3cbff31bec4",
                    "menuSectionId": "5e7b98f40b2595e44af26c1b",
                    "menuType": "standard",
                    "price": 1000
                }
            ],
            "name": "SINGLE_PRICE"
        },
        {
            "bundleItemSizeAttributes": null,
            "bundleSectionSizeAttributes": null,
            "id": "5ea1ec19c8393636ebc2fec6",
            "menuAttributes": [
                {
                    "index": 0,
                    "isVariablePrice": false,
                    "menuId": "5e6bee157ed0c3cbff31bec4",
                    "menuSectionId": "5e7b98f40b2595e44af26c1b",
                    "menuType": "standard",
                    "price": 1200
                }
            ],
            "name": "Big"
        }
    ],
    "subcategory": "",
    "title": "Omelet",
    "type": [
        "menu"
    ],
    "updatedAt": "2020-08-30T23:56:46.851Z",
    "venueId": "5e623ce8b28a16bd4a724fca"
}
"""
}
