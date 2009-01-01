From: Robert Reif <reif@earthlink.net>
Date: Thu, 01 Jan 2009 07:10:39 +0000
Subject: Re: [RFC PATCH] use sparc64 version of of_device.c
Message-Id: <495C6C6F.2030803@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4945AE56.2040503@earthlink.net>
In-Reply-To: <4945AE56.2040503@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sam Ravnborg wrote:
>> +#ifdef CONFIG_SPARC64
>>  void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name)
>>  {
>>  	unsigned long ret = res->start + offset;
>> @@ -34,6 +35,7 @@ void of_iounmap(struct resource *res, void __iomem *base, unsigned long size)
>>  		release_region((unsigned long) base, size);
>>  }
>>  EXPORT_SYMBOL(of_iounmap);
>> +#endif
>>     
>
> For sparc32 we have these in ioport.c.
> So the better alternative would maybe have been to move them
> to a ioport_64 file?
>   
Wouldn't it be better to use these in sparc32?  This would require
using 64 bit resources. We could then use generic code.  This and
switching to bootmem allocations in irq.c would eliminate a good
chunk of ioport.c by using generic or shared code.
