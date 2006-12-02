From: David Miller <davem@davemloft.net>
Date: Sat, 02 Dec 2006 04:18:59 +0000
Subject: Re: [PATCH] sparc{,64}: propagate ptrace_traceme() return value
Message-Id: <20061201.201859.18284568.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alexey Dobriyan <adobriyan@openvz.org>
Date: Wed, 29 Nov 2006 11:42:09 +0300

> ptrace_traceme() consolidation made
> 
> 	ret = ptrace_traceme();
> 
> dead write.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>

Applied, thanks Alexey.
