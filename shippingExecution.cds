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
	account @();
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