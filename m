From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Fri, 08 Aug 2008 10:56:35 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <a4423d670808080356r6573102am8a1eb9dcc83910c8@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670808080231nc4d5e25q6636fe8ff090b84@mail.gmail.com>
	 <20080808.024024.205614839.davem@davemloft.net>
	 <a4423d670808080314weed9178o9f9ef52803a68501@mail.gmail.com>
	 <20080808.033811.129671951.davem@davemloft.net>
In-Reply-To: <20080808.033811.129671951.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mikpe@it.uu.se, kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

2008/8/8 David Miller <davem@davemloft.net>:
>> Yes, I applied it manually on top of 2.6.27-rc2-0166
>
> And then the problem goes away right?
>
No, It hangs in the same way, right after
console handover: boot [earlyprom0] -> real [tty0]
