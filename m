From: Elad Lahav <elad_lahav@users.sourceforge.net>
Date: Tue, 10 Mar 2009 02:54:26 +0000
Subject: Re: Signal handler arguments
Message-Id: <49B5D662.3090906@users.sourceforge.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B543AF.4090902@users.sourceforge.net>
In-Reply-To: <49B543AF.4090902@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The actual type of the third argument is architecture independant,
> that is why it is defined as "void *" rather than a specific type.
No. It is always a pointer to a ucontext_t structure. The *details* of 
this structure are architecture-dependent. Please refer to page 1339 in

1003.1TM
Standard for Information Technology
Portable Operating System Interface (POSIX)
System Interfaces, Issue 6
Approved 12 September 2001
The Open Group

> Yes it says ucontext_t and sparc is the lone-wolf out here.
It's not a lone wolf, it's a misguided one.

--Elad
