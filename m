From: David Miller <davem@davemloft.net>
Date: Thu, 20 Jan 2011 00:39:34 +0000
Subject: Re: Documentation for sun4m
Message-Id: <20110119.163934.90811524.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110119225234.GA20692@merkur.ravnborg.org>
In-Reply-To: <20110119225234.GA20692@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jan 2011 16:33:26 -0800 (PST)

> From: Robert Reif <reif@earthlink.net>
> Date: Wed, 19 Jan 2011 18:52:32 -0500
> 
>> Sam Ravnborg wrote:
>>> Do you have any pointers to relevant documentation?
>>>
>>>    
>> http://wikis.sun.com/display/FOSSdocs/Home used to have "Sun-4M System
>> Architecture (revision 2.0)" by Chuck Narad online but I guess Oracle
>> took it offline.  I have a copy I can send.
> 
> Oh that's rediculious that they took it offline.

BTW, there is also:

http://www.ibiblio.org/pub/historic-linux/early-ports/Sparc/NCR/NCR89C105.txt

Also, the qemu sparc folks have implemented a full virtual sun4m system
controller driver in the qemu tree.  It is based upon the NCR and the
Sun-4M system architecture PDF.


