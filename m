From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 26 Apr 2016 15:49:49 +0000
Subject: Re: [Crash-utility] [PATCH V3 0/3] sparc64 support for crash utility
Message-Id: <f8903123-edd2-da14-c556-269c395a48d9@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <118769276.65112900.1461685422983.JavaMail.zimbra@redhat.com>
In-Reply-To: <118769276.65112900.1461685422983.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/26/2016 10:43 AM, Dave Anderson wrote:
> Dave,
> 
> I'm about to check your stuff in, but one additional item needs to be added
> to configure.c for the crash.spec file.  What's the proper sparc64 name string
> that should be added to the "ExclusiveArch:" list?

sparc64 seems to make the most sense.

Thanks,
Dave

> 
> Thanks,
>   Dave
