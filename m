From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 14 Jul 2017 21:48:04 +0000
Subject: Re: [PATCH v2] sparc64: Prevent perf from running during super critical sections
Message-Id: <67084b21-45b5-6091-4e76-a8b164a5a3df@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1500045627-451648-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1500045627-451648-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 07/14/2017 03:43 PM, David Miller wrote:
> From: Rob Gardner <rob.gardner@oracle.com>
> Date: Fri, 14 Jul 2017 15:39:01 -0600
>
>> If you don't mind, we'll use it and your sample code and tie up all
>> the loose ends (ie, modify all the callers of tsb_context_switch etc)
>> and make another revision to the patch.
> It works completely as-is, nothing else needs to be modified.
>

Ah I didn't see that you added a macro to cover up the parameter change.

You didn't leave much work for us to do. ;)

Rob

