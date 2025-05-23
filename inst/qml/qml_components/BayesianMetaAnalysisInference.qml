//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//
import QtQuick
import QtQuick.Layouts
import JASP.Controls

Section
{
	title:		qsTr("Inference")
	expanded:	true

	property alias modelTypeValue:			modelType.value
	property alias modelDirectionValue:		modelDirection.value

	GridLayout
	{
		columns: 2

		//// Analysis choices ////
		RadioButtonGroup
		{
			name: 	"model"
			title: 	qsTr("Model")
			id:		modelType

			RadioButton
			{
				value: 				"fixed"
				label: 				qsTr("Fixed effects")
				onCheckedChanged:	{
					bayesianMetaAnalysisAdvanced.priorH0FEValue = 0.5
					bayesianMetaAnalysisAdvanced.priorH1FEValue = 0.5
					bayesianMetaAnalysisAdvanced.priorH0REValue = 0
					bayesianMetaAnalysisAdvanced.priorH1REValue = 0
				}
			}

			RadioButton
			{
				value: 				"random"
				label: 				qsTr("Random effects")
				onCheckedChanged:	if(checked) {
					bayesianMetaAnalysisAdvanced.priorH0FEValue = 0
					bayesianMetaAnalysisAdvanced.priorH1FEValue = 0
					bayesianMetaAnalysisAdvanced.priorH0REValue = 0.5
					bayesianMetaAnalysisAdvanced.priorH1REValue = 0.5
				}
			}

			RadioButton
			{
				value: 				"averaging"
				label: 				qsTr("Model averaging")
				checked: 			true
				onCheckedChanged:	if(checked) {
					bayesianMetaAnalysisAdvanced.priorH0FEValue = 0.25
					bayesianMetaAnalysisAdvanced.priorH1FEValue = 0.25
					bayesianMetaAnalysisAdvanced.priorH0REValue = 0.25
					bayesianMetaAnalysisAdvanced.priorH1REValue = 0.25
				}
			}

			RadioButton
			{
				value: 				"constrainedRandom"
				label: 				qsTr("Constrained random effects")
				onCheckedChanged:	if(checked) {
					bayesianMetaAnalysisAdvanced.priorH0FEValue = 0.25
					bayesianMetaAnalysisAdvanced.priorH1FEValue = 0.25
					bayesianMetaAnalysisAdvanced.priorH0REValue = 0.25
					bayesianMetaAnalysisAdvanced.priorH1REValue = 0.25
				}

				// Constrain effect sizes to be all positive or all negative
				RadioButtonGroup
				{
					name:	"constrainedRandomDirection"
					id:		modelDirection

					columns: 2

					RadioButton
					{
						value: 		"positive"
						label: 		qsTr("All positive")
						checked:	true
					}

					RadioButton
					{
						value: 	"negative"
						label: 	qsTr("All negative")
					}
				}
			}
		}

		//// Tables ////
		Group
		{
		  title: qsTr("Table")

			CheckBox
			{
				name: 	"modelProbability";
				label: 	qsTr("Model probabilities")
			}

			CheckBox
			{
				name: 	"effectSizePerStudy";
				label: 	qsTr("Effect sizes per study")
			}
		}

		//// BF ////
		BayesFactorType { }

	}
}
