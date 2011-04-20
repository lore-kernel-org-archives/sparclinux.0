From: David Miller <davem@davemloft.net>
Date: Wed, 20 Apr 2011 05:14:36 +0000
Subject: Re: [PATCH 2/3] sparc32: cleanup code for pci init
Message-Id: <20110419.221436.226770718.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110419181910.GA20041@merkur.ravnborg.org>
In-Reply-To: <20110419181910.GA20041@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 19 Apr 2011 20:19:10 +0200

> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 17 Apr 2011 13:49:55 +0200
> Subject: [PATCH 2/3] sparc32: cleanup code for pci init
> 
> Move the ifdeffery to a header file to make the logic more
> obvious where we decide between PCI or SBUS init
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
