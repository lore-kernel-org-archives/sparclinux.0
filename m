From: David Miller <davem@davemloft.net>
Date: Wed, 21 Dec 2016 18:07:53 +0000
Subject: Re: [PATCH] sparc64: shut down to OBP correctly
Message-Id: <20161221.130753.2162911703182344219.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1482340333-65764-1-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1482340333-65764-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Larry Bassel <larry.bassel@oracle.com>
Date: Wed, 21 Dec 2016 09:12:13 -0800

> Orabug: 24789774
> 
> The command "shutdown -h -H now" should shut down the system to
> OBP, however the machine was incorrectly being powered off instead
> (on both LDOM and bare metal).
> 
> The "exit" command to the OBP must be run and then a hard
> loop to prevent return to the kernel.
> 
> Signed-off-by: Larry Bassel <larry.bassel@oracle.com>

On LDOM, once you boot past the early stages of the kernel, OBP is
considered volatile and thus unusable.

That's why I did a direct LDOM shutdown here.
