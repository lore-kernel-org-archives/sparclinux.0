From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Wed, 22 Jul 2015 01:27:42 +0000
Subject: Re: [PATCH 2/3] mfd: Remove MFD_CROS_EC depends on X86 || ARM
Message-Id: <CABxcv=n3wygNTaqJA=P0TyNdud-RMR0y9+ttix-MBzo2Gy75cg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1435191645-6022-1-git-send-email-javier.martinez@collabora.co.uk>
	<1435191645-6022-3-git-send-email-javier.martinez@collabora.co.uk>
	<20150625083854.GV15013@x1>
	<558BBF6C.7000906@collabora.co.uk>
	<20150722011300.GF4477@windriver.com>
In-Reply-To: <20150722011300.GF4477@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@windriver.com>, Olof Johansson <olof@lixom.net>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Lee Jones <lee.jones@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, Gwendal Grignou <gwendal@google.com>, Doug Anderson <dianders@chromium.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-next@vger.kernel.org, sparclinux@vger.kernel.org

Hello Paul,

On Wed, Jul 22, 2015 at 3:13 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> [Re: [PATCH 2/3] mfd: Remove MFD_CROS_EC depends on X86 || ARM] On 25/06/2015 (Thu 10:44) Javier Martinez Canillas wrote:
>
>> Hello Lee,
>>
>> On 06/25/2015 10:38 AM, Lee Jones wrote:
>> > On Thu, 25 Jun 2015, Javier Martinez Canillas wrote:
>> >
>> >> A dependency on X86 || ARM for MFD_CROS_EC was added to fix the warning:
>> >>
>> >> (MFD_CROS_EC) selects CHROME_PLATFORMS which has unmet direct dependencies (X86 || ARM)
>> >>
>> >> This happened because CHROME_PLATFORMS had a dependency on X86 || ARM but
>> >> that dependency was removed since there isn't a reason why the option can
>> >> not be selected on other architectures. So now the above warning will not
>> >> happen and the MFD_CROS_EC dependency can be removed since is not needed.
>> >>
>> >> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> >> ---
>> >>
>> >>  drivers/mfd/Kconfig | 1 -
>> >>  1 file changed, 1 deletion(-)
>> >
>> > Applied for v4.3, thanks.
>> >
>>
>> Thanks a lot.
>>
>> Olof,
>>
>> Could you please ack patch 1/3 so Lee can pick it through the mfd tree?
>> Since both patches 1/3 and 2/3 are needed to fix the build warning for
>> !X86 and !ARM architectures.
>
> Hi all,
>
> Wondering if this fell through the cracks.  It used to be just a
> linux-next issue, but now it is a mainline issue.  This _really_ should
> be fixed and fed to Linus ASAP.  Ideally it should have been fixed before
> going to mainline as it was reported in plenty of time ; that is the
> whole point of linux-next.... to fix unanticipated fallout and revise.
>

Sorry that I didn't follow up on this but I recently changed jobs and
was quite busy and travelling.

The problem as is explained above in the quoted text is that $subject
is not enough to fix the issue, patch 1/3 should also be picked but
that is waiting for Olof's ack.
I agree that both patches 1/3 and 2/3 have to be sent as an -rc fix
since the commit that introduced the issue made it to 4.2.

Patch 3/3 can wait for 4.3 which BTW I see that has not been applied either.

> ------------------
> paul@builder:~/git/linux-head$ git describe
> v4.2-rc3
> paul@builder:~/git/linux-head$ echo $ARCH
> sparc64
> paul@builder:~/git/linux-head$ make allyesconfig
> scripts/kconfig/conf  --allyesconfig Kconfig
> warning: (MFD_CROS_EC) selects CHROME_PLATFORMS which has unmet direct dependencies (X86 || ARM)
> #
> # configuration written to .config
> #
> paul@builder:~/git/linux-head$
> ------------------
>
> Thanks,
> Paul.
> --
>

Best regards,
Javier
