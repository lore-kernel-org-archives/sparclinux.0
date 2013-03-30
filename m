From: David Miller <davem@davemloft.net>
Date: Sat, 30 Mar 2013 22:01:31 +0000
Subject: Re: [PATCH 2/5] sparc: define __linux__ to fix defconfig build
Message-Id: <20130330.180131.646742358339862130.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364679866-29982-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1364679866-29982-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 22:57:50 +0100

> On Sat, Mar 30, 2013 at 05:46:22PM -0400, David Miller wrote:
>> From: Sam Ravnborg <sam@ravnborg.org>
>> Date: Sat, 30 Mar 2013 22:44:23 +0100
>> 
>> > The gcc version I use do not include a definition of __linux__.
>> 
>> Then it's not a gcc targetting Linux.
> 
> It was built some time ago using crosstool-ng. I added ssupport for sparc
> some time ago - but seems I got it wrong. I should fix that...
> 
> Do you have a configure command I can use to build my own gcc's
> for sparc32 + sparc64 for now?

The only critical option is "--enable-targets=all" which, when building
a 32-bit compiler binary, will enable support for 64-bit code generation.
