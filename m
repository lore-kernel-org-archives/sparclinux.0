From: David Miller <davem@davemloft.net>
Date: Mon, 17 May 2010 17:06:19 +0000
Subject: Re: sun4v_data_access_exception during access to hardware
Message-Id: <20100517.100619.104076443.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100513.042552.242119562.davem@davemloft.net>
In-Reply-To: <20100513.042552.242119562.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex Mach <alexvm12e@mail.ru>
Date: Mon, 17 May 2010 17:26:18 +0400

> 
>> 
>> > The problem happens when ethoc_read() call ioread32() with phys addr
>> > 0xFFF0C2C100.
>> 
>> That means there is nothing responding at that physical address.
> 
> I need some help. If I want to have access to IO device I need to do following:
> 
> 1. Get permission from hypervisor about using the phys addr;
> 2. Convert phys addr to real addr;
> 2. Initialize TSB by this real addr.
> 
> It's right? Which APIs should I use for these actions?

You're likely need to make hypervisor changes to make this work.

There are no APIs for privileged level code to ask the hypervisor to
just do these things.  If it did, the hypervisor would be useless,
it's there exactly to protect the system from privileged code
accessing arbitrary physical and I/O memory.

What probably is the easiest way is to make sure the OpenFirmware
device tree has a proper nodes and mappings for your device.

