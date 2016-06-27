From: Alexandre Chartre <alexandre.chartre@oracle.com>
Date: Mon, 27 Jun 2016 12:38:07 +0000
Subject: Re: Please upgrade your machines to sparc64
Message-Id: <57711E2F.40504@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
In-Reply-To: <756b931c-35f9-e094-94bf-f12839b61d92@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 06/23/2016 10:38 PM, David Miller wrote:
> From: alexmcwhirter@triadic.us
> Date: Thu, 23 Jun 2016 16:12:35 -0400
>
>> 1. Oracle knows sparc32 is faster than sparc64, that's why nearly half
>> of Solaris is 32 bit.
>
> +1
>

Note that Solaris is providing more and more 64-bit binaries. Solaris
libraries are always provided as 32 and 64-bit to ensure backward
compatibility. But new Solaris binaries are usually 64-bit only.

alex.
