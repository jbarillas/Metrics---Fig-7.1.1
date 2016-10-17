

###############################################################################################
# This is the empirical example for the paper "Quantile Regression under Misspecification" by 
# J. Angrist, V. Chernozhukov and I. Fernandez-Val
###############################################################################################

###########################################################
# PROGRAM: FIGURES 1 (CENSUS 1980)                        #
#		- FIGURE 1: CQ, KB QR & C QR's and WEIGHTS#
###########################################################

require(foreign);

memory.limit(size=500000000);
######################################################################################### 
# GROUPED DATA (AT THE SCHOOLING CELL LEVEL)						#
######################################################################################### 
# VARIABLES:										#
#											#
# 1 - educ		schooling							#
# 1 - cqlogwk.q## 	conditional quantile function					#
# 2 - qrlogwk.q## 	KB quatile regression						#
# 3 - cqrlogwk.q##	Chamberlain's MD line						#
# 4 - wqr5.q##		Importance weights						#
# 5 - awqr5.q##		QR weights = importance weights * histogram of schooling	#
# 6 - dwqr2.q##		Density weights							#
######################################################################################### 
setwd(file.choose())
data<-read.dta("census80g.dta", convert.underscore = TRUE);
attach(data);


######################################################################################### 
# INDIVIDUAL DATA (TO CONSTRUCT THE HISTOGRAM)						#
######################################################################################### 
# VARIABLES:										#
#											#
# 1 - idata.educ	schooling							#
######################################################################################### 

idata<-read.dta("census80i.dta", convert.underscore = TRUE);


setEPS()
postscript("figure1.eps",horizontal=FALSE,onefile=FALSE,height=6,width=8,pointsize=10);


par(mfrow=c(2,3), oma=(c(0,0,2,0)));
plot(educ,cqlogwk.q10,xlab="Schooling",ylab="Log-earnings",ylim=c(5,6.5),main="", col = 'steelblue1');
title(main=expression(bold(paste("A. ", tau," = 0.10"))) );
lines(educ,qrlogwk.q10, col = 'red');
par(lty=2, lwd=2, col = 'blue');
lines(educ,cqrlogwk.q10);
par(lty=1, lwd=1, col = 1);
legend(5,6.5,c("CQ","QR","MD"),lty=c(-1,1,2),pch=c(1,-1,-1),lwd=c(1,1,2),bty="n",col=c('steelblue1', 'red','blue'));


par(yaxp = c(5.5,8,4));
plot(educ,cqlogwk.q50,xlab="Schooling",ylab="Log-earnings",ylim=c(5.5,7),main="", col = 'steelblue1' );
title(main=expression(bold(paste("B. ", tau," = 0.50"))) );
par(lty=1);
lines(educ,qrlogwk.q50, col = 'red');
par(lty=2, lwd=2, col = 'blue');
lines(educ,cqrlogwk.q50);
par(lty=1, lwd=1, col =1);
legend(5,7,c("CQ","QR","MD"),lty=c(-1,1,2),pch=c(1,-1,-1),lwd=c(1,1,2),bty="n",col=c('steelblue1', 'red','blue'));


plot(educ,cqlogwk.q90,xlab="Schooling",ylab="Log-earnings",ylim=c(6.25,7.75),main="", col = 'steelblue1' );
title(main=expression(bold(paste("C. ", tau," = 0.90"))) );
par(lty=1);
lines(educ,qrlogwk.q90, col = 'red');
par(lty=2, lwd=2, col = 'blue');
lines(educ,cqrlogwk.q90);
par(lty=1, lwd=1, col=1);
legend(5,7.75,c("CQ","QR","MD"),lty=c(-1,1,2),pch=c(1,-1,-1),lwd=c(1,1,2),bty="n",col=c('steelblue1', 'red','blue'));


par(lty=1);
plot(educ,wqr5.q10,xlab="Schooling",ylab="Weight",type="l",ylim=c(0,0.5),main="", col = 'red' );
title(main=expression(bold(paste("D. ", tau," = 0.10"))) );
par(lty=2, lwd=2, col = 'blue');
lines(educ,dwqr2.q10);
par(lty=6, lwd=1, col = 'steelblue1');
lines(educ,awqr5.q10);
par(lty=1,col=1);
legend(12.5,0.52,c("QR weights","Imp. weights","Den. weights"),lty=c(6,1,2),col=c('steelblue1', 'red','blue'),lwd=c(1,1,2),bty="n");


par(lty=1,col=1);
plot(educ,wqr5.q50,xlab="Schooling",ylab="Weight",type="l",ylim=c(0,0.5) ,main="", col = 'red' );
title(main=expression(bold(paste("E. ", tau," = 0.50"))) );
par(lty=2, lwd=2, col = 'blue');
lines(educ,dwqr2.q50);
par(lty=6, lwd=1, col = 'steelblue1');
lines(educ,awqr5.q50);
par(lty=1,col=1);
legend(12.5,0.52,c("QR weights","Imp. weights","Den. weights"),lty=c(6,1,2),col=c('steelblue1', 'red','blue'),lwd=c(1,1,2),bty="n");


par(lty=1,col = 1);
plot(educ,wqr5.q90,xlab="Schooling",ylab="Weight",type="l",ylim=c(0,0.5) ,main="", col = 'red' );
title(main=expression(bold(paste("F. ", tau," = 0.90"))) );
par(lty=2, lwd=2, col = 'blue');
lines(educ,dwqr2.q90);
par(lty=6, lwd=1, col = 'steelblue1');
lines(educ,awqr5.q90);
par(lty=1,col=1);
legend(12.5,0.52,c("QR weights","Imp. weights","Den. weights"),lty=c(6,1,2),col=c('steelblue1', 'red','blue'),lwd=c(1,1,2),bty="n");

mtext(expression(bold("Replication of Figure 7.1.1 by Josh Barillas")), side = 3, line = 0, outer = TRUE, cex = 1.3)

dev.off();



detach(data);
rm(data,idata);


ls();
q();
