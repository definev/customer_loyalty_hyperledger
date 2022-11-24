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
	Member        string `json:"member" binding:"required"`
	Partner       string `json:"partner" binding:"required"`
	Points        int    `json:"points" binding:"required"`
	timestamp     time.Time
	transactionId string
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
		savedMember, err := contract.EvaluateTransaction("CreateMember", string(memberJson))
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
		log.Printf("%v\n", savedMember)

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

		confirmPartnerStr, err := contract.EvaluateTransaction("CreatePartner", string(partnerJson))
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

		confirmEarnPointsStr, err := contract.EvaluateTransaction("EarnPoints", string(earnPointsJson))
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

		confirmUsePointsStr, err := contract.EvaluateTransaction("UsePoints", string(usePointsJson))
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

func MemberData(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		type Body struct {
			AccountNumber string `json:"accountNumber" binding:"required"`
		}

		body := Body{}

		if err := ctx.Bind(&body); err != nil {
			ctx.String(http.StatusBadRequest, fmt.Sprintf("Failed to bind : %s", err))
			return
		}

		memberJson, err := contract.EvaluateTransaction("GetState", body.AccountNumber)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		member := Member{}
		err = json.Unmarshal(memberJson, &member)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Save wrong format : %v", err))
		}

		ctx.JSON(http.StatusOK, member)
	}
}

func PartnerData(contract *client.Contract) gin.HandlerFunc {
	return func(ctx *gin.Context) {
		type Body struct {
			PartnerId string `json:"partnerId" binding:"required"`
		}

		body := Body{}

		if err := ctx.Bind(&body); err != nil {
			ctx.String(http.StatusBadRequest, fmt.Sprintf("Failed to bind : %s", err))
			return
		}

		partnerJson, err := contract.EvaluateTransaction("GetState", body.PartnerId)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Something went wrong : %v", err))
			return
		}

		partner := Partner{}
		err = json.Unmarshal(partnerJson, &partner)
		if err != nil {
			ctx.String(http.StatusInternalServerError, fmt.Sprintf("Save wrong format : %v", err))
		}

		ctx.JSON(http.StatusOK, partner)
	}
}

func InitLedger(contract *client.Contract) {
	_, err := contract.EvaluateTransaction("InitLedger")
	if err != nil {
		log.Fatalf("can not InitLedger %s", err)
	}
}
