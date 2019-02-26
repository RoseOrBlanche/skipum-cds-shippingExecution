namespace com.skipum.shippingExecution;

using com.skipum.common.codes as cds from '@contax/skipum-common';
using com.skipum.common.packaging as pkg from '@contax/skipum-common';
using com.skipum.common.measures as msr from '@contax/skipum-common';
using com.skipum.common.geographic as geo from '@contax/skipum-common';
using com.skipum.common.businessPartner as bp from '@contax/skipum-common';
using com.skipum.common.contentSource as cs from '@contax/skipum-common';
using com.skipum.common.businessObject as bo from '@contax/skipum-common';
using com.skipum.common.currency as cur from '@contax/skipum-common';
using com.skipum.common.carrier as car from '@contax/skipum-common';

type ShipmentProcessingStatusCode: cds.Code;

entity ShipmentProcessingStatus: cds.CodeList {
	key code: ShipmentProcessingStatusCode;
	criticality: cds.Criticality;
};

type ShipmentPackingStatusCode: cds.Code;
entity ShipmentPackingStatus: cds.CodeList {
	key code: ShipmentPackingStatusCode;
	criticality: cds.Criticality;
};

type ShipmentPrintingStatusCode: cds.Code;
entity ShipmentPrintingStatus: cds.CodeList {
	key code: ShipmentPrintingStatusCode;
	criticality: cds.Criticality;
}

type ShipmentTransmitStatusCode: cds.Code;
entity ShipmentTransmitStatus: cds.CodeList {
	key code: ShipmentTransmitStatusCode;
	criticality: cds.Criticality;
};

type LegProcessingStatusCode: cds.Code;
entity LegProcessingStatus: cds.CodeList {
	key code: LegProcessingStatusCode;
	criticality: cds.Criticality;
};

type LegPackingStatusCode: cds.Code;
entity LegPackingStatus: cds.CodeList {
	key code: LegPackingStatusCode;
	criticality: cds.Criticality;
};

type LegPrintingStatusCode: cds.Code;
entity LegPrintingStatus: cds.CodeList {
	key code: LegPrintingStatusCode;
	criticality: cds.Criticality;
};

type LegTransmitStatusCode: cds.Code;
entity LegTransmitStatus: cds.CodeList {
	key code: LegTransmitStatusCode;
	criticality: cds.Criticality;
};

type ManifestProcessingStatusCode: cds.Code;
entity ManifestProcessingStatus: cds.CodeList {
	key code: ManifestProcessingStatusCode;
	criticality: cds.Criticality;
};

type PaymentTermCode: cds.Code;
entity PaymentTerm: cds.CodeList {
	key code: PaymentTermCode;
}

type IncoTermCode: cds.Code;
entity Incoterm: cds.CodeList {
	key code: IncoTermCode;
}

type PayerCode: cds.Code;
entity Payer: cds.CodeList {
	key code: PayerCode;
}

type Value: Decimal(15, 2);

type Amount
{
	amount: Value @(ms.ISOCurrency: currency);
	currency: cur.Currency;
};

type ShipDate: Date;

abstract entity Partner: bp.BusinessAddress
{
	key partnerType :  Association to bp.PartnerTypes	@(
		Common: {
			Updatable : false,
			Creatable : false
		}
	);
};

type DeliveryAttributes
{
	appointmentRequired: Boolean;
	deliverToDoor: Boolean;
	directDelivery: Boolean;
	eveningDelivery: Boolean;
	forkliftRequired: Boolean;
	helperRequired: Boolean;
	holidayDelivery: Boolean;
	insideDelivery: Boolean;
	liftgateRequired: Boolean;
	palletJackRequired: Boolean;
	saturdayDelivery: Boolean;
	specialDelivery: Boolean;
	stairDelivery: Boolean;
	sundayDelivery: Boolean;
	unpackedUncrate: Boolean;
}	

type CarrierAccount: String(50);

type Enabled: Boolean;

entity CarrierPayer
{
	payer : Association to Payer;
	account : CarrierAccount;
};

type RequiredDeliveryDate: Date;
type RequestedDeliveryDate: Date;

type ShippingDates
{
	shipDate : ShipDate;
	requestedDeliveryDate : RequestedDeliveryDate;
	requiredDeliveryDate : RequiredDeliveryDate;
};

type References
{
	shipper: String(50);
	consignee: String(50);
	miscellaneous1: String(50);
	miscellaneous2: String(50);
	miscellaneous3: String(50);
	miscellaneous4: String(50);
	miscellaneous5: String(50);
};

entity Shipment: bo.BusinessDocument {
	identifier: String(40);
	processingStatus : Association to ShipmentProcessingStatus;
	printingStatus : Association to ShipmentPrintingStatus;
	packingStatus : Association to ShipmentPackingStatus;
	transmitStatus : Association to ShipmentTransmitStatus;
	legs: Composition of many Leg on legs.shipment = $self;
}

entity LegPartner: Partner
{
	key leg : Association to Leg;
};


entity Leg: bo.BusinessDocument {
	key shipment : Association to Shipment;
	identifier: String(40);
	processingStatus : Association to LegProcessingStatus;
	printingStatus : Association to LegPrintingStatus;
	packingStatus : Association to LegPackingStatus;
	transmitStatus : Association to LegTransmitStatus;
	carrier: Association to car.Carrier;
	service: Association to car.Service;
	carrierPayer : CarrierPayer;
	incoterms : Association to Incoterm;
	shippingDates : ShippingDates;
	references: References;
	deliveryAttributes: DeliveryAttributes;
	handlingUnits: Composition of many HandlingUnit on handlingUnits.leg = $self;
	businessPartners: Composition of many LegPartner on businessPartners.leg = $self;
	manifests: Composition of many Manifest on manifests.leg = $self;
}

type CountNumber: Integer;
type CountLeg
{
	indexOf : CountNumber;
	total : CountNumber;
}

type CountContainer
{
	indexOf : CountNumber;
	total : CountNumber;
}


entity HandlingUnit: bo.BusinessDocument {
	key leg : Association to Leg;
	identifier: String(40);
	description: String(80);
	containerType : Association to pkg.ContainerType;
	shippingWeight: msr.Weight;
	contentWeight: msr.Weight;
	tareWeight: msr.Weight;
	scaleWeight: msr.Weight;
	dimensions: msr.Dimensions;
	packagingType : Association to pkg.PackagingType;
	countLeg: CountLeg;
	countContainer: CountContainer;
}

type DimensionalRated: Boolean;
type HundredWeightRated: Boolean;
type UPSGroundSaver: Boolean;

type ChargeCode: cds.Code;
entity ChargeCodes: cds.CodeList {
	key code: ChargeCode;
};

type ProcessorChargeCode: String(60);

abstract entity ChargeBase
{
	amount: Amount;
	ratedWeight: msr.Weight;
	dimensionalRated: DimensionalRated;
	hundredWeightRated: HundredWeightRated;
	UPSGroundSaver: UPSGroundSaver;
};

abstract entity ChargeItemBase
{
	key chargeCode : Association to ChargeCodes;
	processorChargeCode: ProcessorChargeCode;
	amount: Amount;
};


type TrackingNumber: String(60);
type DeliveryZone: String(30);
type Waybill: String(60);
type ID: String(50);
type ProcessorId: ID;
type ProcessorGroupId: ID;
type ProcessorManifestId: ID;
type ProjectedDaysInTransit: Integer;
type ProjectedDeliveryDate: Date;
type CommitmentTime: Time;

type ProjectedArrival
{
	daysInTransit: ProjectedDaysInTransit;
	deliveryDate: ProjectedDeliveryDate;
	commitmentTime: CommitmentTime;
}

entity Charge: ChargeBase
{
	key manifest: Association to Manifest;
	items: Composition of many ChargeItem on items.charge = $self;
}

entity ChargeItem: ChargeItemBase
{
	key charge: Association to Charge;
}

entity Manifest: bo.BusinessObject {
	key leg: Association to Leg;
	processingStatus : Association to ManifestProcessingStatus;
	shipDate: ShipDate;
	processorId01: ProcessorId;
	processorId02: ProcessorId;
	processorGroupId01: ProcessorGroupId;
	processorGroupId02: ProcessorGroupId;
	projectedArrival: ProjectedArrival;
	deliveryZone: DeliveryZone;
	contentSource: cs.ContentSource;
	processorReturn: cs.ProcessorReturn;
	items: Composition of many Item on items.manifest = $self;
	charges: Composition of many Charge on charges.manifest = $self;
}

entity Item {
	key manifest : Association to Manifest;
	processingStatus : Association to ManifestProcessingStatus;
	trackingNumber: TrackingNumber;
	trackingNumberAlternate01: TrackingNumber;
	trackingNumberAlternate02: TrackingNumber;
	waybill: Waybill;
	processorId01: ProcessorId;
	processorId02: ProcessorId;
	processorGroupId01: ProcessorGroupId;
	processorGroupId02: ProcessorGroupId;
	processorManifestId01: ProcessorManifestId;
	processorManifestId02: ProcessorManifestId;
	projectedArrival: ProjectedArrival;
}

/*
UI Annotations
*/

annotate ShipmentProcessingStatus
@( // header-level annotations
	UI:
	{
		DataPoint#StatusCriticality:
		{
			Value: code,
			Criticality: criticality,
			Title: '{i18n>processingStatus}'
		},
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>processingStatusCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>processingStatus}',
		UI:
		{
			HiddenFilter: true
		}
	);
	criticality @(
		UI:
		{
			HiddenFilter: true,
			Hidden : true
		}
	);
};

annotate ShipmentPackingStatus
@( // header-level annotations
	UI:
	{
		DataPoint#StatusCriticality:
		{
			Value: code,
			Criticality: criticality,
			Title: '{i18n>packingStatus}'
		},
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>packingStatusCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>packingStatus}',
		UI:
		{
			HiddenFilter: true
		}
	);
	criticality @(
		UI:
		{
			HiddenFilter: true,
			Hidden : true
		}
	);
};

annotate ShipmentPrintingStatus
@( // header-level annotations
	UI:
	{
		DataPoint#StatusCriticality:
		{
			Value: code,
			Criticality: criticality,
			Title: '{i18n>printingStatus}'
		},
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>printingStatusCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>printingStatus}',
		UI:
		{
			HiddenFilter: true
		}
	);
	criticality @(
		UI:
		{
			HiddenFilter: true,
			Hidden : true
		}
	);
};

annotate ShipmentTransmitStatus
@( // header-level annotations
	UI:
	{
		DataPoint#StatusCriticality:
		{
			Value: code,
			Criticality: criticality,
			Title: '{i18n>transmitStatus}'
		},
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>transmitStatusCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>transmitStatus}',
		UI:
		{
			HiddenFilter: true
		}
	);
	criticality @(
		UI:
		{
			HiddenFilter: true,
			Hidden : true
		}
	);
};

annotate LegProcessingStatus
@( // header-level annotations
	UI:
	{
		DataPoint#StatusCriticality:
		{
			Value: code,
			Criticality: criticality,
			Title: '{i18n>processingStatus}'
		},
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>processingStatusCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>processingStatus}',
		UI:
		{
			HiddenFilter: true
		}
	);
	criticality @(
		UI:
		{
			HiddenFilter: true,
			Hidden : true
		}
	);
};

annotate LegPackingStatus
@( // header-level annotations
	UI:
	{
		DataPoint#StatusCriticality:
		{
			Value: code,
			Criticality: criticality,
			Title: '{i18n>packingStatus}'
		},
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>packingStatusCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>packingStatus}',
		UI:
		{
			HiddenFilter: true
		}
	);
	criticality @(
		UI:
		{
			HiddenFilter: true,
			Hidden : true
		}
	);
};

annotate LegPrintingStatus
@( // header-level annotations
	UI:
	{
		DataPoint#StatusCriticality:
		{
			Value: code,
			Criticality: criticality,
			Title: '{i18n>printingStatus}'
		},
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>printingStatusCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>printingStatus}',
		UI:
		{
			HiddenFilter: true
		}
	);
	criticality @(
		UI:
		{
			HiddenFilter: true,
			Hidden : true
		}
	);
};

annotate LegTransmitStatus
@( // header-level annotations
	UI:
	{
		DataPoint#StatusCriticality:
		{
			Value: code,
			Criticality: criticality,
			Title: '{i18n>transmitStatus}'
		},
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>transmitStatusCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>transmitStatus}',
		UI:
		{
			HiddenFilter: true
		}
	);
	criticality @(
		UI:
		{
			HiddenFilter: true,
			Hidden : true
		}
	);
};

annotate ManifestProcessingStatus
@( // header-level annotations
	UI:
	{
		DataPoint#StatusCriticality:
		{
			Value: code,
			Criticality: criticality,
			Title: '{i18n>processingStatus}'
		},
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>processingStatusCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>processingStatus}',
		UI:
		{
			HiddenFilter: true
		}
	);
	criticality @(
		UI:
		{
			HiddenFilter: true,
			Hidden : true
		}
	);
};


annotate Incoterm
@( // header-level annotations
	UI:
	{
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>incoTermsCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>incoTerms}',
		UI:
		{
			HiddenFilter: true
		}
	);
};

annotate PaymentTerm
@( // header-level annotations
	UI:
	{
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>paymentTermsCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>paymentTerms}',
		UI:
		{
			HiddenFilter: true
		}
	);
};

annotate Payer
@( // header-level annotations
	UI:
	{
		Identification: [
			{
				$Type: 'UI.DataField',
				Value: name
			}
		]
	}
)
{
	code @(
		title: '{i18n>carrierPayerCode}',
		Common:
		{
			Text: {$value: name, "@UI.TextArrangement": #TextOnly},
		},
		UI:
		{
			HiddenFilter: true
		}
	);
	name @(
		title: '{i18n>carrierPayer}',
		UI:
		{
			HiddenFilter: true
		}
	);
};

annotate CarrierAccount @(
	title: '{i18n>carrierAccount}'
);

annotate Enabled @(
	title: '{i18n>enabled}'
);

annotate CarrierPayer
{
	payer @(
		title: '{i18n>carrierPayer}',
		Common:
		{
			Text: {$value: payer.name, "@UI.TextArrangement": #TextOnly},
			ValueList: {entity: 'CarrierPayers', type: #fixed},
			ValueListWithFixedValues
		}
	);
	account;
};

annotate DeliveryAttributes
{
	appointmentRequired @(
		title: '{i18n>appointmentRequired}'
	);

	deliverToDoor @(
		title: '{i18n>deliverToDoor}'
	);

	directDelivery @(
		title: '{i18n>directDelivery}'
	);

	eveningDelivery @(
		title: '{i18n>eveningDelivery}'
	);

	forkliftRequired @(
		title: '{i18n>forkliftRequired}'
	);

	helperRequired @(
		title: '{i18n>helperRequired}'
	);

	holidayDelivery @(
		title: '{i18n>holidayDelivery}'
	);

	insideDelivery @(
		title: '{i18n>insideDelivery}'
	);

	liftgateRequired @(
		title: '{i18n>liftgateRequired}'
	);

	palletJackRequired @(
		title: '{i18n>palletJackRequired}'
	);

	saturdayDelivery @(
		title: '{i18n>saturdayDelivery}'
	);

	specialDelivery @(
		title: '{i18n>specialDelivery}'
	);

	stairDelivery @(
		title: '{i18n>stairDelivery}'
	);

	sundayDelivery @(
		title: '{i18n>sundayDelivery}'
	);

	unpackedUncrate @(
		title: '{i18n>unpackedUncrate}'
	);
}	

annotate Value @(
	title: '{i18n>amount}'
);
	
annotate Amount
{
	currency @(
		Common: {
			Text: {$value: cy.name, "@UI.TextArrangement": #TextFirst},
			ValueList: {entity: 'Currencies', type: #fixed},
			ValueListWithFixedValues
		}
	);
};
	
annotate ShipDate @(
	title: '{i18n>shipDate}'
);

annotate RequiredDeliveryDate @(
	title: '{i18n>requiredDeliveryDate}'
);

annotate RequestedDeliveryDate @(
	title: '{i18n>requestedDeliveryDate}'
);

annotate References
{
	shipper @(
		title: '{i18n>shipperReference}'
	);
	consignee @(
		title: '{i18n>consigneeReference}'
	);
	miscellaneous1 @(
		title: '{i18n>miscellaneousReference1}'
	);
	miscellaneous2 @(
		title: '{i18n>miscellaneousReference2}'
	);
	miscellaneous3 @(
		title: '{i18n>miscellaneousReference3}'
	);
	miscellaneous4 @(
		title: '{i18n>miscellaneousReference4}'
	);
	miscellaneous5 @(
		title: '{i18n>miscellaneousReference5}'
	);
}

annotate Partner
{
	partnerType	@(
		Common: {
			Text: {$value: partnerType.name, "@UI.TextArrangement": #TextOnly},
			ValueList: {entity: 'PartnerTypes', type: #fixed},
			ValueListWithFixedValues,
			FieldControl : #ReadOnly,
		}
	);
}