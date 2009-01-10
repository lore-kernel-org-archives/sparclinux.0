From: Robert Reif <reif@earthlink.net>
Date: Sat, 10 Jan 2009 04:19:19 +0000
Subject: Re: sparc32 broke
Message-Id: <496821C7.9030801@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49669B15.7020107@earthlink.net>
In-Reply-To: <49669B15.7020107@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Robert Reif wrote:
> Prior to today, sparc32 has also failed to boot completely for the 
> last few days.
> It boots but fails in the init scripts when it can't find the boot 
> partition.
>
> Ill try to bisect the boot problem but it will take a while.
I bisected it down to: ece93487c31607558f4b91f378fcee4b43956dbc sparc: 
unify signal.h
