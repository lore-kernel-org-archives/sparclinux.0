From: Meelis Roos <mroos@linux.ee>
Date: Thu, 26 Sep 2013 18:08:56 +0000
Subject: Re: include/linux/version.h not updated
Message-Id: <alpine.SOC.1.00.1309262107190.27277@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20130926.002304.2121420558807412031.davem@davemloft.net> <alpine.SOC.1.00.1309261347030.11084@math.ut.ee> <alpine.SOC.1.00.1309261601050.11084@math.ut.ee> <20130926.132628.780580796759839483.davem@redhat.com>
In-Reply-To: <20130926.132628.780580796759839483.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@redhat.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

> > -rw-r--r-- 1 mroos mroos 97 Sep 20 21:56 include/generated/uapi/linux/version.h
> > -rw-r--r-- 1 mroos mroos 97 Aug 10  2012 ./include/linux/version.h
> 
> It's not the it doesn't get updated.
> 
> It's that the file in your GIT tree is unsync'd.
> 
> You need to "rm include/linux/version.h" and I bet that beforehand a
> "git stat" will show "include/linux/version.h" as a spurious file.
> 
> Because of your situation, the second file is being included first,
> overriding the right file, the first one.

Yes, you are absolutely correct. head_64.o was rebuild with correcxt 
verion information.

A lot of machines will have this file removed :)

-- 
Meelis Roos (mroos@linux.ee)
