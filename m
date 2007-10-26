From: Bernd Zeimetz <bernd@bzed.de>
Date: Fri, 26 Oct 2007 22:40:20 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <47226CD4.8080401@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>> For those who can reproduce it an have something like libnss-db
>> enabled, try disabling it.

- disabled it
- running vgdisplay killed the machine (wanted to create a new LV for a
chroot....)... it's not accessible at all anymore, I think the kernel is
a 2.6.23-something here, I'll build a recent one and give it a try
again.... Will take some time as I need to build on USII...


-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
