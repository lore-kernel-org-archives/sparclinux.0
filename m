From: Rob Gardner <rob.gardner@oracle.com>
Date: Sun, 01 Apr 2018 18:42:46 +0000
Subject: Re: [PATCH] sparc64: Properly range check DAX completion index
Message-Id: <f84b4cf7-1ff5-036f-e961-ef8af15b7a27@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1522558381-31281-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1522558381-31281-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/01/2018 11:11 AM, Linus Torvalds wrote:
> On Sat, Mar 31, 2018 at 9:53 PM, Rob Gardner <rob.gardner@oracle.com> wrote:
>> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
>> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> That Reported-by: should be "oguard <oguard@protonmail.com>"
>
> I was just the messenger.
>
>                  Linus


oguard observed "lack of size check on the copy_from_user", but that 
wasn't really a bug since 'count' actually is checked in dax_write().

But you noticed that idx could be negative and idx + nccbs could 
overflow, and this is a genuine bug that nobody else saw.

Rob

