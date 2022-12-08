/*
*	Copyright PKA.CPD . All Rights Reserved.
*	SPDX-License-Identifier: Apache-2.0
 */

package handler

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/hyperledger/fabric-gateway/pkg/client"
)

type Member struct {
	CardId        string `json:"cardId" binding:"required"`
	AccountNumber string `json:"accountNumber" binding:"required"`
	FirstName     string `json:"firstName" binding:"required"`
	LastName      string `json:"lastName" binding:"required"`
	Email         string `json:"email" binding:"required"`
	PhoneNumber   string `json:"phoneNumber" binding:"required"`
}
type Partner struct {
	Name   string `json:"name" binding:"required"`
	Id     string `json:"partnerId" binding:"required"`
	CardId string `json:"cardId" binding:"required"`
}

type PointTransaction struct {
	TransactionId string    `json:"transactionId"`
	Member        string    `json:"member" binding:"required"`
	Partner       string    `json:"partner" binding:"required"`
	Points        int       `json:"points" binding:"required"`
	Timestamp     time.Time `json:"timestamp"`
}



func CreateMember(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		member := Member{}
		if err := ctx.Bind(&member); err != nil {
			ctx.String(http.StatusBadRequest, fmt.Sprintf("%s", err))
			return
		}

		memberJson, err := json.Marshal(member)
		if err != nil {
			ctx.String(http.StatusInternalServerError, err.Error())
			return
		}
		savedMember, err := contract.SubmitTransaction("CreateMember", string(memberJson))
		if err != nil {
			ctx.String(http.StatusInternalServerError, err.Error())
			return
		}
		confirmMember := Member{}
		err = json.Unmarshal(savedMember, &confirmMember)
		if err != nil {
			ctx.String(http.StatusInternalServerError, err.Error())
			return
		}
		log.Printf("%v\n", string(savedMember))

		ctx.JSON(http.StatusOK, confirmMember)
	}
}

func CreatePartner(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		partner := Partner{}

		if err := ctx.Bind(&partner); err != nil {
			ctx.String(http.StatusBadRequest, fmt.Sprintf("Failed to bind : %s", err))
			return
		}

		partnerJson, err := json.Marshal(partner)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something wrong in server : %v", err))
			return
		}

		confirmPartnerStr, err := contract.SubmitTransaction("CreatePartner", string(partnerJson))
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something wrong in server : %v", err))
			return
		}

		confirmPartner := Partner{}
		err = json.Unmarshal(confirmPartnerStr, &confirmPartner)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something wrong in server : %v", err))
			return
		}

		ctx.JSON(http.StatusOK, confirmPartner)
	}
}

func EarnPoints(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		earnPoints := PointTransaction{}

		if err := ctx.Bind(&earnPoints); err != nil {
			ctx.String(http.StatusBadRequest, fmt.Sprintf("Failed to bind : %s", err))
			return
		}

		earnPointsJson, err := json.Marshal(earnPoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something wrong in server : %v", err))
			return
		}

		confirmEarnPointsStr, err := contract.SubmitTransaction("EarnPoints", string(earnPointsJson))
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something wrong in server : %v", err))
			return
		}

		confirmEarnPoints := PointTransaction{}
		err = json.Unmarshal(confirmEarnPointsStr, &confirmEarnPoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something wrong in server : %v", err))
			return
		}

		ctx.JSON(http.StatusOK, confirmEarnPoints)
	}
}

func UsePoints(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		usePoints := PointTransaction{}

		if err := ctx.Bind(&usePoints); err != nil {
			ctx.String(http.StatusBadRequest, fmt.Sprintf("Failed to bind : %s", err))
			return
		}

		usePointsJson, err := json.Marshal(usePoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something wrong in server : %v", err))
			return
		}

		confirmUsePointsStr, err := contract.SubmitTransaction("UsePoints", string(usePointsJson))
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something wrong in server : %v", err))
			return
		}

		confirmUsePoints := PointTransaction{}
		err = json.Unmarshal(confirmUsePointsStr, &confirmUsePoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something wrong in server : %v", err))
			return
		}

		ctx.JSON(http.StatusOK, confirmUsePoints)
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

		earnedPointsJson, err := contract.SubmitTransaction("GetEarnedPoints", body.AccountNumber)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		earnedPoints := PointTransaction{}
		err = json.Unmarshal(earnedPointsJson, &earnedPoints)
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

		usedPointsJson, err := contract.SubmitTransaction("GetUsedPoints", body.AccountNumber)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		usedPoints := PointTransaction{}
		err = json.Unmarshal(usedPointsJson, &usedPoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		ctx.JSON(http.StatusOK, usedPoints)
	}
}

func MemberData(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		returnedData := map[string]any{}

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
		}

		var memberMap map[string]any
		data, _ := json.Marshal(member)
		json.Unmarshal(data, &memberMap)
		for k, v := range memberMap {
			returnedData[k] = v
		}

		// ----- USE POINTS FETCH -----
		// fetchUsePoints
		usePointsJson, err := contract.SubmitTransaction("UsePointsTransactionsInfo", "member", body.AccountNumber)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Contract error : %v", err))
		}

		usePoints := []PointTransaction{}
		err = json.Unmarshal(usePointsJson, &usePoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Failed to parse earn point : %v", err))
		}

		returnedData["usePointsResults"] = usePoints
			
		// ----- EARN POINTS FETCH -----
		// fetchEarnPoints
		earnPointsJson, err := contract.SubmitTransaction("EarnPointsTransactionsInfo", "member", body.AccountNumber)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Contract error : %v", err))
		}

		earnPoints := []PointTransaction{}
		err = json.Unmarshal(earnPointsJson, &earnPoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Failed to parse earn point : %v", err))
		}

		returnedData["earnPointsResults"] = earnPoints

		// ----- PARTNER INFO -----
		allPartnersJson, err := contract.SubmitTransaction("GetState", "all-partners")
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Failed to get all-partners : %s", err))
			return
		}

		allPartners := []Partner{}
		err = json.Unmarshal(allPartnersJson, &allPartners)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Failed to parse allPartnersJson : %s", string(allPartnersJson)))
			return
		}

		returnedData["partnersData"] = allPartners

		returnedData["points"] = totalPoints(earnPoints) - totalPoints(usePoints)

		ctx.JSON(http.StatusOK, returnedData)
	}
}

func PartnerData(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		returnedData := map[string]any{}

		type Body struct {
			PartnerId string `json:"partnerId" binding:"required"`
			CardId    string `json:"cardId" binding:"required"`
		}

		body := Body{}

		if err := ctx.Bind(&body); err != nil {
			ctx.String(http.StatusBadRequest, fmt.Sprintf("Failed to bind : %s", err))
			return
		}

		// ----- PARTNER FETCH -----
		// fetchPartner
		partnerJson, err := contract.SubmitTransaction("GetState", body.PartnerId)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		partner := Partner{}
		err = json.Unmarshal(partnerJson, &partner)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Save wrong format : %v | VALUE : %v", err, string(partnerJson)))
			return
		}

		returnedData["id"] = partner.Id
		returnedData["name"] = partner.Name

		// ----- EARN POINTS FETCH -----
		// fetchEarnPoints
		earnPointsJson, err := contract.SubmitTransaction("EarnPointsTransactionsInfo", "partner", body.PartnerId)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Contract error : %v", err))
		}

		earnPoints := []PointTransaction{}
		err = json.Unmarshal(earnPointsJson, &earnPoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Failed to parse earn point : %v", err))
		}

		returnedData["earnPointsResults"] = earnPoints
		returnedData["pointsCollected"] = totalPoints(earnPoints)

		// ----- USE POINTS FETCH -----
		// fetchUsePoints
		usePointsJson, err := contract.SubmitTransaction("UsePointsTransactionsInfo", "partner", body.PartnerId)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Contract error : %v", err))
		}

		usePoints := []PointTransaction{}
		err = json.Unmarshal(usePointsJson, &usePoints)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Failed to parse use point : %v", err))
		}

		returnedData["usePointsResults"] = usePoints
		returnedData["pointsGiven"] = totalPoints(usePoints)

		ctx.JSON(http.StatusOK, returnedData)
	}
}

func InitLedger(contract *client.Contract) {
	_, err := contract.SubmitTransaction("InitLedger")
	if err != nil {
		log.Fatalf("can not InitLedger %s", err)
	}
}

func totalPoints(pointsTransactions []PointTransaction) int {
	//loop through and add all points from the transactions
	totalPointsGiven := 0
	for i := 0; i < len(pointsTransactions); i++ {
		totalPointsGiven = totalPointsGiven + pointsTransactions[i].Points
	}
	return totalPointsGiven
}
