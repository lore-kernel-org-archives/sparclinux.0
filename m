From: David Miller <davem@davemloft.net>
Date: Sun, 14 Mar 2010 00:21:37 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <20100313.162137.82715595.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 13 Mar 2010 22:33:17 +0100

> On Sat, 2010-03-13 at 11:19 -0800, David Miller wrote:
>> From: David Miller <davem@davemloft.net>
>> Date: Sat, 13 Mar 2010 11:12:41 -0800 (PST)
>> > 
>> > So once the kernel switches from the PROM console output and
>> > into the framebuffer driver, the characters printed are blue?
>> > 
>> > What color is the screen background when this happens?
>> 
>> Meanwhile I think I know what the problem is, please try
>> this patch on top of what you have:
> 
> Yes ... {being happy}
> 
> sunxvr1000
> Acked-by: Frans van Berckel <fberckel@xs4all.nl>

Thanks for testing, I'll push this new driver around.
