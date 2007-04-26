<link href="dhtmlpopup/dhtmlPopup.css" rel="stylesheet" type="text/css" />
<link href="dhtmlpopup/dhtmlCommentPopup.css" rel="stylesheet" type="text/css" />
<script src="dhtmlpopup/dhtmlPopup.js" type="text/javascript"></script>
<script src="js/frameAdjust.js" type="text/javascript"></script>

<f:view>
	<div class="portletBody">
	  <h:form id="gbForm">
		<sakai:flowState bean="#{studentViewBean}" />

		<h2>
			<h:outputFormat value="#{msgs.student_view_page_title}"/>
			<h:outputFormat value="#{studentViewBean.userDisplayName}"/>
		</h2>

		<h:panelGrid cellpadding="0" cellspacing="0"
			columns="2"
			columnClasses="itemName"
			styleClass="itemSummary">	
			<h:outputText value="#{msgs.student_view_cum_score}" />
			<h:panelGroup>
				<h:outputFormat value=" #{msgs.student_view_cum_score_details}" rendered="#{studentViewBean.percent != null}">
					<f:param value="#{studentViewBean.percent}" />
				</h:outputFormat>
			</h:panelGroup>
			
			<h:outputText value="#{msgs.student_view_course_grade}" />
			<h:panelGroup>
				<h:outputText value="#{msgs.student_view_not_released}" rendered="#{!studentViewBean.courseGradeReleased}"/>
				<h:outputText value="#{studentViewBean.courseGrade}" rendered="#{studentViewBean.courseGradeReleased}"/>	
			</h:panelGroup>
		</h:panelGrid>

      <h:panelGroup rendered="#{studentViewBean.assignmentsReleased}">
				<f:verbatim><h4></f:verbatim>
					<h:outputText value="#{msgs.student_view_assignments}"/>
				<f:verbatim></h4></f:verbatim>
			</h:panelGroup>
			
			<gbx:gradebookItemTable cellpadding="0" cellspacing="0"
				value="#{studentViewBean.gradebookItems}"
				var="row"
        sortColumn="#{studentViewBean.sortColumn}"
				sortAscending="#{studentViewBean.sortAscending}"
				columnClasses="attach,left,left,center,center,left,external"
				rowClasses="#{studentViewBean.rowStyles}"
				styleClass="listHier wideTable lines"
				rendered="#{studentViewBean.assignmentsReleased}"
				expanded="true">
				
				<h:column id="_toggle" rendered="#{studentViewBean.categoriesEnabled}">
					<f:facet name="header">
						<h:outputText value="" />
					</f:facet>
				</h:column>
				
				<h:column id="_title">
					<f:facet name="header">
						<t:commandSortHeader columnName="name" immediate="true" arrow="true">
							<h:outputText value="#{msgs.student_view_title}"/>
						</t:commandSortHeader>
					</f:facet>
					<h:outputText value="#{row.associatedAssignment.name}" rendered="#{row.assignment}"/>
					<h:outputText value="#{row.name}" styleClass="categoryHeading" rendered="#{row.category}"/>
				</h:column>
				
				<h:column>
					<f:facet name="header">
						<t:commandSortHeader columnName="dueDate" immediate="true" arrow="true">
							<h:outputText value="#{msgs.student_view_due_date}"/>
						</t:commandSortHeader>
					</f:facet>

					<h:outputText value="#{row.associatedAssignment.dueDate}" rendered="#{row.assignment && row.associatedAssignment.dueDate != null}">
						<gbx:convertDateTime />
					</h:outputText>
					<h:outputText value="#{msgs.score_null_placeholder}" rendered="#{row.assignment && row.associatedAssignment.dueDate == null}"/>
				</h:column>
				
				<h:column>
					<f:facet name="header">
						<t:commandSortHeader columnName="pointsEarned" immediate="true" arrow="true">
							<h:outputText value="#{msgs.student_view_grade}"/>
						</t:commandSortHeader>
					</f:facet>

          <h:outputText value="#{row}" escape="false">
						<f:converter converterId="org.sakaiproject.gradebook.jsf.converter.CLASS_AVG_CONVERTER"/>
					</h:outputText>
        </h:column>
        
        <h:column rendered="#{studentViewBean.weightingEnabled}">
					<f:facet name="header">
			    	<t:commandSortHeader columnName="weight" immediate="true" arrow="true">
							<h:outputText value="#{msgs.student_view_weight}"/>
			      </t:commandSortHeader>
			    </f:facet>
	
					<h:outputText value="#{row.weight}" rendered="#{row.category}">
						<f:converter converterId="org.sakaiproject.gradebook.jsf.converter.PERCENTAGE" />
					</h:outputText>
				</h:column>
	    
		    <h:column>
	        <f:facet name="header">
	        	<h:outputText value="#{msgs.student_view_comment_header}"/>
	        </f:facet>
	        <h:outputText value="#{row.commentText}" rendered="#{row.assignment && row.commentText != null}" />
		    </h:column>
		    
		    <h:column>
		       <h:outputText value="#{row.associatedAssignment.externalAppName}" rendered="#{row.assignment}" />
		    </h:column>
		  </gbx:gradebookItemTable>

</h:form>
</div>
</f:view>
