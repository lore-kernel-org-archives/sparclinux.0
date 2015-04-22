From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 22 Apr 2015 23:30:21 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <55382F0D.7060905@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/22/2015 04:51 PM, David Miller wrote:
>
> David, are there any major M7 patches remaining for basic
> functionality?
>

There is one more patch I am working on that would be part of basic 
functionality. M7 introduces the register MCDPER which determines 
whether a precise or a disrupting exception will be delivered to a task 
when it encounters MCD error. This should be a per task value and hence 
will need to become part of task context (thread info flags maybe). I am 
working on code to save and restore this register on context switches, 
and propagate it on task dup.

--
Khalid

