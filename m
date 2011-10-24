From: Josip Rodin <josip.rodin@carnet.hr>
Date: Mon, 24 Oct 2011 13:26:56 +0000
Subject: Re: 3.0.4 kernel oops in i2c ?
Message-Id: <20111024132656.GA27540@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111014144345.GB5070@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20111014144345.GB5070@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Oct 14, 2011 at 04:43:45PM +0200, Hermann Lauer wrote:
> when starting 3.0.4 on a V880 a non fatal oops happens when loading
> i2c stuff. Proably there is a problem with i2c on the machine,
> as the rsc "env" cmd shows "E880_FSP: ERROR getting FP stats ---> 9"
> errors. An old 2.6.26-2-sparc64-smp (Debian 2.6.26-26lenny2) kernel
> produces no oops.

Can you try the stable Debian 2.6.32 kernel at least?

Anything that helps you reduce the amount of git bisect...

-- 
     2. That which causes joy or happiness.
