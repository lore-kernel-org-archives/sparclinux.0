From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Thu, 05 Nov 2009 14:39:38 +0000
Subject: Re: [PATCH] Support for GRLIB APBUART serial port
Message-Id: <4AF2E3AA.5010605@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257352368-32377-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257352368-32377-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Kristoffer Glembo <kristoffer@gaisler.com>
> Date: Wed,  4 Nov 2009 17:32:48 +0100
> 
>> This patch adds support for the APBUART serial port from Aeroflex
>> Gaisler's IP library GRLIB. It is currently used in all LEON3 designs
>> (SPARC V8) but can be used on other platforms as well (which support OF).
>>
>>
>> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
> 
> Applied, but I had to make two fixes:
>

Thanks a lot. I will remember to test drivers as modules and on other
architectures in the future!

Best regards,
Kristoffer Glembo
