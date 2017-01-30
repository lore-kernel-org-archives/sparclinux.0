From: David Miller <davem@davemloft.net>
Date: Mon, 30 Jan 2017 22:23:29 +0000
Subject: Re: [PATCH v4] sparc64: shut down to OBP correctly
Message-Id: <20170130.172329.975043215670465949.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1483637013-52889-1-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1483637013-52889-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Larry Bassel <larry.bassel@oracle.com>
Date: Thu,  5 Jan 2017 09:23:33 -0800

> The command "shutdown -h -H now" should shut the system down to the
> OBP, however the machine was being powered off in the LDOM case.
> 
> In the LDOM case, the "reboot-command" variable must be set to
> the string "noop" and then ldom_reboot() must be called.
> This will make the OBP ignore the setting of "auto-boot?" after it
> completes the reset. This causes the system to stop at the ok prompt.
> 
> Signed-off-by: Larry Bassel <larry.bassel@oracle.com>

This really doesn't make any sense.

The purpose of shutting down to the "OK" prompt is to inspect the
system state using OBP commands from the context of the currently
running kernel boot.

If you allow the software reset to happen and then force a stop at the
"OK" prompt, the intention of the facility has been completely
compromised so this is pointless.

User's who want the behavior you mention can get it by setting the
reboot-command variable from userspace using the 'eeprom' or similar
commands, and then simply reboot.

I am not applying this patch, sorry.

