<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setBundle basename="messages"/>

<style>
    .footer-line {
        background: linear-gradient(90deg, rgba(253, 29, 29, 1) 0%, rgba(252, 176, 69, 1) 100%);
    }
    .feature-box {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        background-color: #FFF5E6 !important;
        text-align: center;
    }

    .feature h3 {
        color: #FF6B00;
        font-size: 18px;
    }

    .feature p {
        color: #666;
        font-size: 14px;
        line-height: 1.4;
    }
    .footer a {
        color: #E55D00;
        text-decoration: none;
        transition: color 0.3s ease, text-decoration 0.3s ease;
        font-weight: 500;
    }

    .footer a:hover {
        color: #CC4400;
        text-decoration: underline;
    }
</style>

<div class="footer mt-5 pt-4 pb-4 text-muted">
    <div class="footer-line py-1"></div>
    <div class="feature-box pt-5 pb-5 mb-4">
        <div class="container">
            <div class="row">
                <div class="col-md-4 feature">
                    <h3><fmt:message key="footer.commit.title"/></h3>
                    <p><fmt:message key="footer.commit.desc"/></p>
                </div>
                <div class="col-md-4 feature">
                    <h3><fmt:message key="footer.delivery.title"/></h3>
                    <p><fmt:message key="footer.delivery.desc"/></p>
                </div>
                <div class="col-md-4 feature">
                    <h3><fmt:message key="footer.support.title"/></h3>
                    <p><fmt:message key="footer.support.desc"/></p>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-3">
                <h6><fmt:message key="footer.about.title"/></h6>
                <ul class="list-unstyled">
                    <li><a href="#"><fmt:message key="footer.about.intro"/></a></li>
                    <li><a href="#"><fmt:message key="footer.about.jobs"/></a></li>
                    <li><a href="#"><fmt:message key="footer.about.terms"/></a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h6><fmt:message key="footer.policy.title"/></h6>
                <ul class="list-unstyled">
                    <li><a href="#"><fmt:message key="footer.policy.privacy"/></a></li>
                    <li><a href="#"><fmt:message key="footer.policy.return"/></a></li>
                    <li><a href="#"><fmt:message key="footer.policy.shipping"/></a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h6><fmt:message key="footer.support.title2"/></h6>
                <ul class="list-unstyled">
                    <li><a href="#"><fmt:message key="footer.support.center"/></a></li>
                    <li><a href="#"><fmt:message key="footer.support.contact"/></a></li>
                    <li><a href="#"><fmt:message key="footer.support.guide"/></a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h6><fmt:message key="footer.contact.title"/></h6>
                <ul class="list-unstyled">
                    <li><fmt:message key="footer.contact.email"/></li>
                    <li><fmt:message key="footer.contact.hotline"/></li>
                    <li><fmt:message key="footer.contact.address"/></li>
                </ul>
            </div>
        </div>
        <hr>
        <div class="text-center small"><fmt:message key="footer.copyright"/></div>
    </div>
</div>
