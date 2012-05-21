From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 21 May 2012 18:54:00 +0000
Subject: Re: [PATCH] net: drop NET dependency from HAVE_BPF_JIT
Message-Id: <CA+55aFwo6XusR8pNY+dp_5uFNqCxZjeWWL6h+V=PFqT884Qc_A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120521.050300.1434374935904126254.davem@davemloft.net>
 <CA+55aFzag=LfduvHSmE34nEVYOk=MRhUMzK854+icLwthmz5Ng@mail.gmail.com>
 <20120521182400.GA6043@merkur.ravnborg.org> <CA+55aFymRE-_1qzCA_n3xYbMseQrZsjJWWX74S3jn5Qyf9Efjw@mail.gmail.com>
 <CA+55aFy4He9X6wQjATaJukzH1FkyhGqnmC4kb+azKuMmjPGbmg@mail.gmail.com> <20120521185202.GA6486@merkur.ravnborg.org>
In-Reply-To: <20120521185202.GA6486@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 21, 2012 at 11:52 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Fix up all users to drop the dependency on NET now that
> it is not required to supress warnings for non-NET builds.

Do you want me to take this directly, or will it go through the net
tree? I can live with it either way.

               Linus
