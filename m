From: Balint Cristian <cristian.balint@oradea.rdsnet.ro>
Date: Mon, 19 Dec 2005 12:03:18 +0000
Subject: Re: BTTV and SPARC
Message-Id: <200512191403.19153.cristian.balint@oradea.rdsnet.ro>
List-Id: <sparclinux.vger.kernel.org>
References: <20051218101536.22906.qmail@webmail.rdslink.ro>
In-Reply-To: <20051218101536.22906.qmail@webmail.rdslink.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sunday 18 December 2005 12:15, boera@rdslink.ro wrote:
> Hi,
> 
> I have posted already my problem on the Debian SPARC list, but unfortunately I didn't 
> receive any suggestions.
> The problem is connected with the bttv driver.
> Machine: Sun Ultra 10 (360 MHz), onboard ATI video card.
> Kernels tested: 2.6.14, 2.6.15 rc4 and rc5
> The bttv driver seems to work fine but the machine locks up hard after about 20 minutes.
> No error messages in the logs.
> It seems to me that the lockup happens everytime after the same time interval.
> I have tried with 2 different TV tuners (Jetway PCITV and Leadtek Winfast 2000 XP), the
> result is the same.
> I would like to know if bttv is supposed to work under SPARC, or the machine just cannot
> handle the I/O bandwidth.

2 years ago played with 2.4.x series, it worked at last [bt848] was recognized OK, but encoding the stream was horrible slow
and loosy using mencoder.
I/O was OK, i played using motion project with http://motion.sf.net sensor where playng was not a problem it worked 
on 500Mhz PII too.

	I am curios that encoding using vlc  [videolan] e.g how work, it is much more sane than mencoder for e.g


> 
> Best regards,
> Boer Attila
> 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
Balint Cristian
area network engineer
.............................................................................
RCS & RDS  Oradea
Tel.: +40359.400.400
Fax: +40359.400.444
http://www.rcs-rds.ro
        suport@rdsor.ro
....................................................................................
Privileged/Confidential Information may be contained in this message. 
If you are not in the addresses indicated in this message (or responsible
for delivery of the message to such person), you may not copy or deliver
this message to anyone. In such a case, you should destroy this 
message and kindly notify the sender by reply e-mail. 
