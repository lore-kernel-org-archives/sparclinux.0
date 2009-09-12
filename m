From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 12 Sep 2009 09:53:02 +0000
Subject: Re: [GIT]: Sparc
Message-Id: <20090912095302.GA30123@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20080421.153231.108090227.davem@davemloft.net>
In-Reply-To: <20080421.153231.108090227.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Sep 11, 2009 at 09:01:56PM -0700, David Miller wrote:
>       sparc64: Manage NMI watchdog enabling like x86.

Dave, do you expect anything to have changed regarding the v240 NMI hang
because of this change to atomic*(), should we give it a try?

-- 
     2. That which causes joy or happiness.
