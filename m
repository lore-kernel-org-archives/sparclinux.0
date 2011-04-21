From: David Miller <davem@davemloft.net>
Date: Thu, 21 Apr 2011 22:46:34 +0000
Subject: Re: [PATCH 2/3] sparc: consolidate show_cpuinfo in cpu.c
Message-Id: <20110421.154634.189715986.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1303330141-31123-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1303330141-31123-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 22:09:00 +0200

> We have all the cpu related info in cpu.c - so move
> the remaining functions to support /proc/cpuinfo to this file.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied to sparc-next-2.6
