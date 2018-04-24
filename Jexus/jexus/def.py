import socket
import os

print "%s:%s" % ('SOCK_STREAM',socket.SOCK_STREAM)
print "%s:%s" % ('SOCK_DGRAM',socket.SOCK_DGRAM)
print '%s:%s' % ('SO_SNDBUF',socket.SO_SNDBUF)
print '%s:%s' % ('SO_RCVBUF',socket.SO_RCVBUF)
print '%s:%s' % ('SO_SNDTIMEO',socket.SO_SNDTIMEO)
print '%s:%s' % ('SO_RCVTIMEO',socket.SO_RCVTIMEO)
print '%s:%s' % ('SO_LINGER',socket.SO_LINGER)
print '%s:%s' % ('SO_REUSEADDR',socket.SO_REUSEADDR)
print '%s:%s' % ('SO_ERROR',socket.SO_ERROR)
print '%s:%s' % ('TCP_NODELAY',socket.TCP_NODELAY)

if hasattr(socket,'TCP_CORK'):
    print '%s:%s' % ('TCP_CORK',socket.TCP_CORK)

if hasattr(socket,'MSG_OOB'):
    print '%s:%s' % ('MSG_OOB',socket.MSG_OOB)

if hasattr(socket,'MSG_PEEK'):
    print '%s:%s' % ('MSG_PEEK',socket.MSG_PEEK)

if hasattr(socket,'MSG_WAITALL'):
    print '%s:%s' % ('MSG_WAITALL',socket.MSG_WAITALL)

if hasattr(socket,'SOL_SOCKET'):
    print '%s:%s' % ('SOL_SOCKET',socket.SOL_SOCKET)

if hasattr(os,'O_NONBLOCK'):
    print '%s:%s' % ('O_NONBLOCK',os.O_NONBLOCK)


