From: "Grant Likely" <grant.likely@secretlab.ca>
Date: Thu, 21 Aug 2008 23:14:57 +0000
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-Id: <fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080821.001012.265401427.davem@davemloft.net>
	 <20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	 <20080821.142134.127315039.davem@davemloft.net>
	 <48ADDF86.2040200@freescale.com>
In-Reply-To: <48ADDF86.2040200@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scott Wood <scottwood@freescale.com>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, devicetree-discuss@ozlabs.org

On Thu, Aug 21, 2008 at 3:35 PM, Scott Wood <scottwood@freescale.com> wrote:
> David Miller wrote:
>>>
>>> On Thu, Aug 21, 2008 at 12:10:12AM -0700, David Miller wrote:
>> If you guys created this format in your compressed openfirmware
>> trees, is it possible for you to "fix" it to match what Sparc
>> systems following the proper bindings do?
>
> Possibly, though it'll cause some pain when old trees are used with a kernel
> that expects the new binding.

Ugh, more like loads of pain.  There are deployed platforms using the
embedded 'invented' bindings.  I don't think it is an option to break
compatibility with older trees.  If there is some backwards
compatibility code then I'm all for migrating to the same binding as
Sparc and PowerMac

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
