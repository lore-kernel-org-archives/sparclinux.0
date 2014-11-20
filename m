From: David Drysdale <drysdale@google.com>
Date: Thu, 20 Nov 2014 12:12:23 +0000
Subject: Re: sparc: Clashing values for O_PATH and FMODE_NONOTIFY?
Message-Id: <CAHse=S-f5o3vbT+b1D5baEWCWMUnDyLSxM88+vwwymFuLrTirg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAHse=S_EY3mJ_pdZf+A46joro_uNy=6tXGG1v7Va4NX_YxJu2w@mail.gmail.com>
 <20141119.153001.1273476178846053821.davem@davemloft.net>
In-Reply-To: <20141119.153001.1273476178846053821.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, Eric Paris <eparis@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org

[+linux-fsdevel, without the typo this time]

On Wed, Nov 19, 2014 at 8:30 PM, David Miller <davem@davemloft.net> wrote:
> From: David Drysdale <drysdale@google.com>
> Date: Tue, 18 Nov 2014 13:13:51 +0000
>
>> Hi folks,
>>
>> It looks like the value for O_PATH on sparc:
>>
>>   arch/sparc/include/uapi/asm/fcntl.h:37:#define O_PATH 0x1000000
>>
>> clashes with the arch-independent value for __FMODE_NONOTIFY:
>>
>>   include/linux/fs.h:137:#define FMODE_NONOTIFY ((__force fmode_t)0x1000000)
>>   include/linux/fs.h:2764:#define __FMODE_NONOTIFY ((__force int)
>> FMODE_NONOTIFY)
>>
>> and they are both in the same numbering space, as indicated by the
>> comment at the top of include/uapi/asm-generic/fcntl.h and the use in
>> fs/notify/fanotify/fanotify_user.c:715.
>>
>> Presumably this could theoretically cause problems (no notifications for
>> O_PATH files on SPARC?), so would it be a good idea to renumber
>> FMODE_NONOTIFY?  (I *think* that value is entirely kernel-internal.)
>>
>> Given that this has happened before (12ed2e36c98aec6c4155 "fanotify:
>> FMODE_NONOTIFY and __O_SYNC in sparc conflict") it would probably
>> also be a good idea to add __FMODE_NOTIFY to the uniqueness check in
>> fs/fcntl.c:fcntl_init().
>>
>> Thoughts?
>
> I think you will need to change the internal value, to not clash with
> the sparc exported one, for sure.

Well, I was sort of hoping someone else might volunteer to make the
change :-) --  I don't use fanotify (or sparc for that matter), I just
happened to notice the clash in passing.

But I'm happy to have a go, although I can't test much.  It would be
good to hear from the fanotify maintainers first, though -- Eric?

Thanks,
David
