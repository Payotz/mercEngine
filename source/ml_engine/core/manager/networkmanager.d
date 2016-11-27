module ml_engine.core.manager.networkmanager;
import derelict.sdl2.sdl;
import derelict.sdl2.net;
import std.conv;
import std.string;

class NetworkManager{
    
    static NetworkManager getInstance(){
        if(!instantiated_){
            synchronized(NetworkManager.classinfo){
                if(!instance_){
                    instance_ = new NetworkManager();
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

    void init(){
        SDLNet_Init();
    }

    void connectTCPTo(string address, int port){
        IPaddress ip; 
        SDLNet_ResolveHost(&ip,toStringz(address),to!ushort(port));
        tcp = SDLNet_TCP_Open(&ip);
    }

    void sendTCPData(const void *data, int len){
        SDLNet_TCP_Send(tcp,data,len);
    }

    void recvTCPData(void *data, int mlen){
        SDLNet_TCP_Recv(tcp,data,mlen);
    }

    /*void connectUDPTo(string address, int port){
        IPaddress ip; 
        SDLNet_ResolveHost(&ip,toStringz(address),to!ushort(port));
        udp = SDLNet_UDP_Open(to!ushort(port));
    }

    void sendUDPData(const void *data, int len){
        SDLNet_UDP_Send(udp,data,len);
    }

    void recvUDPData(const void *data, int len){
        SDLNet_UDP_Recv(data, len);
    }*/

    void hostConnectionTCP(int port){
        IPaddress ip; 
        SDLNet_ResolveHost(&ip,null,to!ushort(port));
        tcp_host = SDLNet_TCP_Open(&ip);
        while (!tcp){
            tcp = SDLNet_TCP_Accept(tcp_host);
        }
    }

    /*void hostConnectionUDP(int port){
        IpAddress ip = SDLNet_ResolveHost(&ip,null,port);
        udp_host = SDLNet_UDP_Open(&ip);
        while(!udp){
            udp = SDLNet_UDP_Accept(udp_host);
        }
    }*/

    void quit(){
        SDLNet_Quit();
        //SDLNet_UDP_Close(udp);
        //SDLNet_UDP_Close(udp_host);
        SDLNet_TCP_Close(tcp_host);
        SDLNet_TCP_Close(tcp);
    }

    
    private:
    TCPsocket tcp;
    TCPsocket tcp_host;
    UDPsocket udp;
    UDPsocket udp_host;
    __gshared NetworkManager instance_;
    static bool instantiated_;
    this(){

    }
}