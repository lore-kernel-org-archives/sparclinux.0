From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Fri, 25 Mar 2016 03:39:11 +0000
Subject: Re: [Patch V2 1/2] sparc64 changes for gdb-7.6
Message-Id: <56F4B2DF.5080201@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1458772868-10255-2-git-send-email-dave.kleikamp@oracle.com>
In-Reply-To: <1458772868-10255-2-git-send-email-dave.kleikamp@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 03/24/2016 07:21 PM, David Miller wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> Date: Thu, 24 Mar 2016 16:01:10 -0500
> 
>> I have to admit that I don't know the whole story here. I took over the
>> crash port, but haven't had to touch the gdb patch that got handed to
>> me. What I do know is crash works off an older 7.6 branch of gdb. I'll
>> get back to you after I talk to some other folks.
> 
> Ok, if you can reproduce the unaligned acces just get a backtrace and
> I think that might help us understand the true issue more quickly.

I'm not sure that is still even needed. It was a workaround that wasn't
meant to be sent upstream, but I didn't know any better. I'll get it
figured out tomorrow.
