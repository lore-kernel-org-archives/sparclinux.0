From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 25 Jul 2017 03:45:33 +0000
Subject: Re: RCU stall warnings...
Message-Id: <20170725134533.3e215be5@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20170724.153248.1457902120749226419.davem@davemloft.net>
        <20170724232033.GI3730@linux.vnet.ibm.com>
        <20170724.163458.1860624258080140141.davem@davemloft.net>
In-Reply-To: <20170724.163458.1860624258080140141.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi Dave,

On Mon, 24 Jul 2017 16:34:58 -0700 (PDT) David Miller <davem@davemloft.net> wrote:
>
> Shoing my ignorance as well, after reading this, for some reason this
> commit below sticks out to me.  Maybe I should do a bisect and see if
> it lands on this commit.
> 
> That would take a while as it's hard to forcibly set this thing off.

For a quick test, just try with the parent of that commit and (if that
is "good") then with that commit itself ...

-- 
Cheers,
Stephen Rothwell
