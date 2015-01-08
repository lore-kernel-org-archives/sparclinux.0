From: David Drysdale <drysdale@google.com>
Date: Thu, 08 Jan 2015 09:06:07 +0000
Subject: Re: [PATCHv2 1/1] vfs: renumber FMODE_NONOTIFY and add to uniqueness check
Message-Id: <CAHse=S8Ht-JcgBqHKttaJTrzp9d8-j=-uRDRoSW+Gwx8hkHkyQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1416828199-3414-1-git-send-email-drysdale@google.com>
 <1416828199-3414-2-git-send-email-drysdale@google.com> <20150106162915.7edb5620999641ebdc7a74e6@linux-foundation.org>
In-Reply-To: <20150106162915.7edb5620999641ebdc7a74e6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Eric Paris <eparis@redhat.com>, David Miller <davem@davemloft.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Wed, Jan 7, 2015 at 12:29 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 24 Nov 2014 11:23:19 +0000 David Drysdale <drysdale@google.com> wrote:
>
>> Fix clashing values for O_PATH and FMODE_NONOTIFY on sparc.
>> The clashing O_PATH value was added in 5229645bdc35f1cc43eb ("vfs: add
>> nonconflicting values for O_PATH") but this can't be changed as it
>> is user-visible.
>>
>> FMODE_NONOTIFY is only used internally in the kernel, but it is in
>> the same numbering space as the other O_* flags, as indicated by the
>> comment at the top of include/uapi/asm-generic/fcntl.h (and its use
>> in fs/notify/fanotify/fanotify_user.c).  So renumber it to avoid
>> the clash.
>>
>> All of this has happened before (12ed2e36c98aec6c4155, "fanotify:
>> FMODE_NONOTIFY and __O_SYNC in sparc conflict"), and all of this
>> will happen again -- so update the uniqueness check in fcntl_init()
>> to include __FMODE_NONOTIFY.
>
> What are the user-visible runtime effects of the bug?
>
> Please always include this info when fixing bugs, so people can work
> out which kernel version(s) need the fix.

I don't know for sure what the user-visible effects are -- I noticed
the problem from the source and I don't have a sparc system (the only
affected architecture) to test with.  But I'd guess that...

The likely user-visible effect (on sparc) of the clash would be that:
- Filesystem activity on files opened with O_PATH does not get
  reported via the fanotify(7) API.
- The file descriptors for accessed objects reported via the
  fanotify(7) API will effectively have O_PATH set, and so will
  have the limitations described for O_PATH in the open(2) manpage.

However, we'd need some intersection of sparc/fanotify folk to verify
those guesses -- Eric / David, any thoughts?

Thanks,
David
