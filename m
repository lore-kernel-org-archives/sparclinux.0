From: Larry Bassel <larry.bassel@oracle.com>
Date: Thu, 16 Mar 2017 16:45:29 +0000
Subject: Re: [PATCH v4] sparc64: shut down to OBP correctly
Message-Id: <20170316164528.GA5226@ubuette>
List-Id: <sparclinux.vger.kernel.org>
References: <1483637013-52889-1-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1483637013-52889-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 30 Jan 17 17:23, David Miller wrote:
> From: Larry Bassel <larry.bassel@oracle.com>
> Date: Thu,  5 Jan 2017 09:23:33 -0800
> 
> > The command "shutdown -h -H now" should shut the system down to the
> > OBP, however the machine was being powered off in the LDOM case.
> > 
> > In the LDOM case, the "reboot-command" variable must be set to
> > the string "noop" and then ldom_reboot() must be called.
> > This will make the OBP ignore the setting of "auto-boot?" after it
> > completes the reset. This causes the system to stop at the ok prompt.
> > 
> > Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
> 
> This really doesn't make any sense.
> 
> The purpose of shutting down to the "OK" prompt is to inspect the
> system state using OBP commands from the context of the currently
> running kernel boot.
> 
> If you allow the software reset to happen and then force a stop at the
> "OK" prompt, the intention of the facility has been completely
> compromised so this is pointless.
> 
> User's who want the behavior you mention can get it by setting the
> reboot-command variable from userspace using the 'eeprom' or similar
> commands, and then simply reboot.
> 
> I am not applying this patch, sorry.

My apologies for the delayed response.

I've gotten feedback from several Oracle people (copied on this
email) that my explanation for why this patch is useful is incomplete:

1. The variable "reboot-command" isn't one of the usual nvram variables,
it's magic and expected to be used for purposes like this (as Solaris
already does). It's not like "boot-device" which sets a permanent default.
It's cleared when it's used by OpenBoot.

2. It's how you can reboot to an alternate kernel once or reboot from
an alternate boot device once, without changing the permanent default.

I'd appreciate it if you'd reconsider accepting this patch.

Thanks.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Larry
