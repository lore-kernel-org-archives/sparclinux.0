From: David Miller <davem@davemloft.net>
Date: Wed, 19 May 2010 20:17:25 +0000
Subject: Re: sun4v_data_access_exception during access to hardware
Message-Id: <20100519.131725.221613305.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100513.042552.242119562.davem@davemloft.net>
In-Reply-To: <20100513.042552.242119562.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Alex Mach" <alexvm12e@mail.ru>
Date: Wed, 19 May 2010 12:53:22 +0400

> 
>> Only drivers/net/niu.c does, it does the physical address handling by
>> hand.
> 
> I'd like try to modify ethoc driver according to niu driver. As I
> understand I've to add some device node(let's call it by Ethoc f.e) to
> OBP device tree as you wrote in one of previous mail. So could you get
> example of the node for niu device, please?

There is nothing special about the NIU device node, it looks like
just any other node in the openfirmware tree for a device.

It merely follows the rules specified by the OpenFirmware
specification for device nodes in that it has a 'name', 'reg',
etc. properties.

What's important in your case is that the code in arch/sparc/kerne/of_device{,_64}.c
and arch/sparc/kernel/prom{,_64}.c builds a correct device node that can be probed
and used in a driver based upon the information contained in those fields.
