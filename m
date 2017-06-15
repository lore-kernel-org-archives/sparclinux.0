From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 15 Jun 2017 20:33:58 +0000
Subject: Re: [v1 0/2] Early boot timestamp fixes
Message-Id: <20170615203358.GA664@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jun 15, 2017 at 04:01:42PM -0400, Pasha Tatashin wrote:
> >
> >Guess that means that qemu doesn't really support this CPU,
> >and your code is fine.
> >
> 
> Thank you very much for testing!
> 
> Do you cross compile linux for sparc or do you compile kernel inside qemu or
> do you have SPARC machine? Just want to figure out what is the best way to
> use qemu for SPARC.
> 

I cross compile Linux for everything :-). See http://kerneltests.org/builders,
and the environment is published at https://github.com/groeck/linux-build-test.

Cheers,
Guenter
