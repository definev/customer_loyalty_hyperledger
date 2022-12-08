/*
*	Copyright PKA.CPD . All Rights Reserved.
*	SPDX-License-Identifier: Apache-2.0
 */

package handler

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/hyperledger/fabric-gateway/pkg/client"
)

func GetMemberData(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		type Body struct {
			AccountNumber string `json:"accountNumber" binding:"required"`
		}
		body := Body{}

		if err := ctx.Bind(&body); err != nil {
			ctx.String(http.StatusBadRequest, fmt.Sprintf("Failed to bind : %s", err))
			return
		}

		// fetchMember
		memberJson, err := contract.SubmitTransaction("GetState", body.AccountNumber)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		member := Member{}
		err = json.Unmarshal(memberJson, &member)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Save wrong format : %v | VALUE : %s", err, string(memberJson)))
			return
		}

		ctx.JSON(http.StatusOK, member)
	}
}

func GetEarnedPoints(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		type Body struct {
			AccountNumber string `json:"accountNumber" binding:"required"`
		}
		body := Body{}

		if err := ctx.Bind(&body); err != nil {
			ctx.String(http.StatusBadRequest, fmt.Sprintf("Failed to bind : %s", err))
			return
		}

		earnPointsJson, err := contract.SubmitTransaction("EarnPointsTransactionsInfo", "member", body.AccountNumber)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		earnedPoints := []PointTransaction{}
		err = json.Unmarshal(earnPointsJson, &earnedPoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		ctx.JSON(http.StatusOK, earnedPoints)
	}
}

func GetUsedPoints(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		type Body struct {
			AccountNumber string `json:"accountNumber" binding:"required"`
		}
		body := Body{}

		if err := ctx.Bind(&body); err != nil {
			ctx.String(http.StatusBadRequest, fmt.Sprintf("Failed to bind : %s", err))
			return
		}

		usePointsJson, err := contract.SubmitTransaction("UsePointsTransactionsInfo", "member", body.AccountNumber)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		usedPoints := []PointTransaction{}
		err = json.Unmarshal(usePointsJson, &usedPoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		ctx.JSON(http.StatusOK, usedPoints)
	}
}
