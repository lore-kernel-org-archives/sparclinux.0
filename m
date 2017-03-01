From: Andi Kleen <andi@firstfloor.org>
Date: Wed, 01 Mar 2017 00:24:28 +0000
Subject: Re: [PATCH v2 1/3] sparc64: NG4 memset 32 bits overflow
Message-Id: <87h93dhmir.fsf@firstfloor.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1488327283-177710-1-git-send-email-pasha.tatashin@oracle.com>
	<1488327283-177710-2-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1488327283-177710-2-git-send-email-pasha.tatashin@oracle.com>
	(Pavel Tatashin's message of "Tue, 28 Feb 2017 19:14:41 -0500")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org

Pavel Tatashin <pasha.tatashin@oracle.com> writes:
>
> While investigating how to improve initialization time of dentry_hashtable
> which is 8G long on M6 ldom with 7T of main memory, I noticed that memset()

I don't think a 8G dentry (or other kernel) hash table makes much
sense. I would rather fix the hash table sizing algorithm to have some
reasonable upper limit than to optimize the zeroing.

I believe there are already boot options for it, but it would be better
if it worked out of the box.

-Andi
