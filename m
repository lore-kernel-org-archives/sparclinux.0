From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Tue, 31 May 2016 14:34:47 +0000
Subject: Re: [RFT PATCH 1/2] serial: Fix console setup section mismatch
Message-Id: <574DA107.8050002@samsung.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1464704372-17668-1-git-send-email-k.kozlowski@samsung.com>
 <20160531142142.GX19428@n2100.arm.linux.org.uk>
In-Reply-To: <20160531142142.GX19428@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 05/31/2016 04:21 PM, Russell King - ARM Linux wrote:
> On Tue, May 31, 2016 at 04:19:31PM +0200, Krzysztof Kozlowski wrote:
>> Remove __init annotation from all of console->setup implementations
>> because:
>> 1. The pointer to it is stored in a struct console which is not
>>    marked with __initdata.
>> 2. It is referenced by register_console() from kernel which is not
>>    marked with __init.
> 
> However, many of these drivers, the console can only be used when the
> driver is built-in, and register_console() is only called early in
> initialisation.

Indeed so maybe the word "fix" in commit subject is not proper because
there might be no error at all. My point is that current solution is a
little bit non-obvious and an error might happen. If we were sure that
register_console() is called only from other __init functions, then it
should be made also __init.

Best regards,
Krzysztof

