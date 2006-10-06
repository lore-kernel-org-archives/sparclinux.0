From: john stultz <johnstul@us.ibm.com>
Date: Fri, 06 Oct 2006 17:53:38 +0000
Subject: Re: [sparc32] 2.6.19-rc1 build error: no tickadj
Message-Id: <1160157218.6140.2.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20061006044940.GA9372@palantir8>
In-Reply-To: <20061006044940.GA9372@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2006-10-06 at 05:49 +0100, Martin Habets wrote:
> Hi,
> 
> Stock 2.6.19-rc1 will not build for sparc32, because tickadj got
> removed and arch/sparc/kernel/time.c still uses it:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0608.2/1742.html
> 
> Does anyone know the proper fix for this?

Roman just sent out the fix for that:
http://www.ussg.iu.edu/hypermail/linux/kernel/0610.0/1511.html

Let us know if that doesn't resolve it.

thanks
-john

