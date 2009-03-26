From: Jan Kara <jack@suse.cz>
Date: Thu, 26 Mar 2009 00:00:36 +0000
Subject: Re: next-20090310: ext4 hangs
Message-Id: <20090326000035.GB11024@duck.suse.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670903110907o7041f4eof92278835aa0c71c@mail.gmail.com> <20090325151122.GA14881@atrey.karlin.mff.cuni.cz> <20090325151516.GB14881@atrey.karlin.mff.cuni.cz> <a4423d670903250818n512b1c67ja1b38db6d09ac7c@mail.gmail.com> <20090325152234.GN23439@duck.suse.cz> <a4423d670903250829w5e9304a7rce24f4220379620f@mail.gmail.com> <20090325161556.GP23439@duck.suse.cz> <a4423d670903251007r72058ca8m28275c1433ab2706@mail.gmail.com> <20090325194316.GQ23439@duck.suse.cz> <a4423d670903251538p3a7c180br1bcfe08c4f044c15@mail.gmail.com>
In-Reply-To: <a4423d670903251538p3a7c180br1bcfe08c4f044c15@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

  Hi,

  thanks for the updated disassembly.

>   55bab0:       82 10 60 01     or  %g1, 1, %g1
>                 spin_unlock(&journal->j_list_lock);
>   55bab4:       40 06 4b 20     call  6ee734 <_spin_unlock>
>   55bab8:       c2 24 e0 28     st  %g1, [ %l3 + 0x28 ]
  OK, so it really seems that:
  jinode->i_flags |= JI_COMMIT_RUNNING;
  spin_unlock(&journal->j_list_lock);

  has been compiled to
  ld [ %l3 + 0x28 ], %g1
  or  %g1, 1, %g1
  call  6ee734 <_spin_unlock>
  st  %g1, [ %l3 + 0x28 ]

  Which seems like a bug in the compiler or in the way implement compiler
barriers in spin_unlock() on UP sparc. Or is there some sparc magic by which
this is correct code? Any clever sparc guy?

									Honza
-- 
Jan Kara <jack@suse.cz>
SUSE Labs, CR
